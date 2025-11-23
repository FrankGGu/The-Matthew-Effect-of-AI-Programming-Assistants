var AuthenticationManager = function(timeToLive) {
    this.timeToLive = timeToLive;
    this.tokens = {};
};

AuthenticationManager.prototype.generate = function(tokenId, currentTime) {
    this.tokens[tokenId] = currentTime + this.timeToLive;
};

AuthenticationManager.prototype.renew = function(tokenId, currentTime) {
    if (this.tokens[tokenId] && this.tokens[tokenId] > currentTime) {
        this.tokens[tokenId] = currentTime + this.timeToLive;
    }
};

AuthenticationManager.prototype.countUnexpiredTokens = function(currentTime) {
    let count = 0;
    for (const time of Object.values(this.tokens)) {
        if (time > currentTime) {
            count++;
        }
    }
    return count;
};