let urlMap = {};
let count = 0;
var encode = function(longUrl) {
    let shortUrl = `http://tinyurl.com/${count}`;
    urlMap[shortUrl] = longUrl;
    count++;
    return shortUrl;
};

var decode = function(shortUrl) {
    return urlMap[shortUrl];
};