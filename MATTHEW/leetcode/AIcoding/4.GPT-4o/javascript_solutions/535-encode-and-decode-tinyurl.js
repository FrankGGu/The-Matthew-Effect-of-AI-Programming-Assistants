class Codec {
    constructor() {
        this.urlMap = new Map();
        this.base = 'http://tinyurl.com/';
        this.counter = 0;
    }

    encode(longUrl) {
        const id = this.counter++;
        const shortUrl = this.base + id.toString(36);
        this.urlMap.set(shortUrl, longUrl);
        return shortUrl;
    }

    decode(shortUrl) {
        return this.urlMap.get(shortUrl) || '';
    }
}