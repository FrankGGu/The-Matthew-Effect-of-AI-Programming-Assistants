type Codec struct {
    m map[string]string
    r map[string]string
    id  int
}

func Constructor() Codec {
    return Codec{m: make(map[string]string), r: make(map[string]string), id: 0}
}

func (this *Codec) encode(longUrl string) string {
    if shortUrl, ok := this.m[longUrl]; ok {
        return shortUrl
    }
    this.id++
    shortUrl := "http://tinyurl.com/" + strconv.Itoa(this.id)
    this.m[longUrl] = shortUrl
    this.r[shortUrl] = longUrl
    return shortUrl
}

func (this *Codec) decode(shortUrl string) string {
    return this.r[shortUrl]
}