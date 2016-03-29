express =require('express')
router = express.Router()
superagent =require('superagent')
cheerio = require('cheerio')

router.get('/', (req, res)->
  superagent.get('https://hao.360.cn/').end((err,response)->
    if err
      console.error(err)
    else
      $ = cheerio.load(response.text)
      urls=[]
      $('#famous-section ul').first().find('li a:nth-child(1)').each(->
        urls.push({
          url:$(this).attr('href').trim()
          title:$(this).text().trim()
        })
      )
      res.send({
        urls:urls
      })
  )
)

module.exports = router;
