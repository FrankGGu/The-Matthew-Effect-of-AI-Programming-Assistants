const encode = function(longUrl) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let shortUrl = '';
    for (let i = 0; i < 6; i++) {
        shortUrl += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    encodeMap.set(shortUrl, longUrl);
    decodeMap.set(longUrl, shortUrl);
    return "http://tinyurl.com/" + shortUrl;
};

const decode = function(shortUrl) {
    const shortCode = shortUrl.replace("http://tinyurl.com/", "");
    return encodeMap.get(shortCode);
};

const encodeMap = new Map();
const decodeMap = new Map();