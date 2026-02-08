var AuthenticationManager = function(timeToLive) {
    this.timeToLive = timeToLive;
    this.tokens = new Map();
};

AuthenticationManager.prototype.generate = function(tokenId, currentTime) {
    this.tokens.set(tokenId, currentTime + this.timeToLive);
};

AuthenticationManager.prototype.renew = function(tokenId, currentTime) {
    if (this.tokens.has(tokenId) {
        const expiryTime = this.tokens.get(tokenId);
        if (expiryTime > currentTime) {
            this.tokens.set(tokenId, currentTime + this.timeToLive);
        }
    }
};

AuthenticationManager.prototype.countUnexpiredTokens = function(currentTime) {
    let count = 0;
    for (const [tokenId, expiryTime] of this.tokens) {
        if (expiryTime > currentTime) {
            count++;
        } else {
            this.tokens.delete(tokenId);
        }
    }
    return count;
};