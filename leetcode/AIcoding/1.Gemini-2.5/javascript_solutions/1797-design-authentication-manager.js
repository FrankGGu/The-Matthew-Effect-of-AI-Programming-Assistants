var AuthenticationManager = function(timeToLive) {
    this.timeToLive = timeToLive;
    this.tokens = new Map();
};

AuthenticationManager.prototype.generate = function(tokenId, currentTime) {
    this.tokens.set(tokenId, currentTime + this.timeToLive);
};

AuthenticationManager.prototype.renew = function(tokenId, currentTime) {
    if (this.tokens.has(tokenId)) {
        const expirationTime = this.tokens.get(tokenId);
        if (expirationTime > currentTime) {
            this.tokens.set(tokenId, currentTime + this.timeToLive);
        }
    }
};

AuthenticationManager.prototype.countUnexpiredTokens = function(currentTime) {
    let count = 0;
    for (const expirationTime of this.tokens.values()) {
        if (expirationTime > currentTime) {
            count++;
        }
    }
    return count;
};