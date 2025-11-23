var AuthenticationManager = function(timeToLive) {
    this.timeToLive = timeToLive;
    this.tokens = new Map();
};

AuthenticationManager.prototype.generate = function(tokenId, currentTime) {
    this.tokens.set(tokenId, currentTime + this.timeToLive);
};

AuthenticationManager.prototype.renew = function(tokenId, currentTime) {
    if (this.tokens.has(tokenId) && this.tokens.get(tokenId) > currentTime) {
        this.tokens.set(tokenId, currentTime + this.timeToLive);
    }
};

AuthenticationManager.prototype.countUnexpiredTokens = function(currentTime) {
    let count = 0;
    for (let expiryTime of this.tokens.values()) {
        if (expiryTime > currentTime) {
            count++;
        }
    }
    return count;
};