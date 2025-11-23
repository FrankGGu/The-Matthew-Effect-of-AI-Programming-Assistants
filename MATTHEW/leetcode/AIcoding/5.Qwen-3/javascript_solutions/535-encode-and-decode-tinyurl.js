var encode = function(longUrl) {
    var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var shortUrl = '';
    for (var i = 0; i < 6; i++) {
        shortUrl += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return shortUrl;
};

var decode = function(shortUrl) {
    return longUrlMap.get(shortUrl);
};

var longUrlMap = new Map();