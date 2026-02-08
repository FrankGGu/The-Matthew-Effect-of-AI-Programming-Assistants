type Codec struct {
    urlMap map[string]string
    counter int
}

func Constructor() Codec {
    return Codec{
        urlMap: make(map[string]string),
        counter: 0,
    }
}

// Encodes a URL to a shortened URL.
func (this *Codec) encode(longUrl string) string {
    shortUrl := fmt.Sprintf("http://tinyurl.com/%d", this.counter)
    this.urlMap[shortUrl] = longUrl
    this.counter++
    return shortUrl
}

// Decodes a shortened URL to its original URL.
func (this *Codec) decode(shortUrl string) string {
    return this.urlMap[shortUrl]
}

/**
 * Your Codec object will be instantiated and called as such:
 * obj := Constructor();
 * url := obj.encode(longUrl);
 * ans := obj.decode(url);
 */