package main

type Codec struct {
    shortToLong map[string]string
    longToShort map[string]string
    counter     int
}

func Constructor() Codec {
    return Codec{
        shortToLong: make(map[string]string),
        longToShort: make(map[string]string),
        counter:     0,
    }
}

func (c *Codec) encode(longUrl string) string {
    if short, ok := c.longToShort[longUrl]; ok {
        return short
    }
    c.counter++
    short := "http://tinyurl.com/" + strconv.Itoa(c.counter)
    c.shortToLong[short] = longUrl
    c.longToShort[longUrl] = short
    return short
}

func (c *Codec) decode(shortUrl string) string {
    return c.shortToLong[shortUrl]
}