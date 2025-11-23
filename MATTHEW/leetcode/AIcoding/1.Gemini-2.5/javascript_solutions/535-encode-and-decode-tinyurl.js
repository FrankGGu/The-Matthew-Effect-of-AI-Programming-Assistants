class Codec {
    constructor() {
        this.map = new Map();
        this.charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        this.baseUrl = "http://tinyurl.com/";
    }

    encode(longUrl) {
        let shortCode;
        do {
            shortCode = "";
            for (let i = 0; i < 6; i++) {
                shortCode += this.charSet.charAt(Math.floor(Math.random() * this.charSet.length));
            }
        } while (this.map.has(shortCode));

        this.map.set(shortCode, longUrl);
        return this.baseUrl + shortCode;
    }

    decode(shortUrl) {
        const shortCode = shortUrl.replace(this.baseUrl, "");
        return this.map.get(shortCode);
    }
}