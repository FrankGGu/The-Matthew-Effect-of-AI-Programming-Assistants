import (
	"math/rand"
	"strings"
)

type Codec struct {
	urlMap map[string]string
	keyMap map[string]string
	alphabet string
}

func Constructor() Codec {
	return Codec{
		urlMap:   make(map[string]string),
		keyMap:   make(map[string]string),
		alphabet: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
	}
}

func (this *Codec) encode(longURL string) string {
	if _, ok := this.urlMap[longURL]; ok {
		return this.urlMap[longURL]
	}

	key := this.generateKey()
	for _, ok := this.keyMap[key]; ok; {
		key = this.generateKey()
	}

	this.urlMap[longURL] = "http://tinyurl.com/" + key
	this.keyMap[key] = longURL

	return "http://tinyurl.com/" + key
}

func (this *Codec) decode(shortURL string) string {
	key := strings.Replace(shortURL, "http://tinyurl.com/", "", 1)
	return this.keyMap[key]
}

func (this *Codec) generateKey() string {
	key := make([]byte, 6)
	for i := range key {
		key[i] = this.alphabet[rand.Intn(len(this.alphabet))]
	}
	return string(key)
}