var Twitter = function() {
    this.tweets = [];
    this.followMap = new Map();
    this.time = 0;
};

Twitter.prototype.postTweet = function(userId, tweetId) {
    this.tweets.push({ userId, tweetId, time: this.time++ });
};

Twitter.prototype.getNewsFeed = function(userId) {
    const result = [];
    const followSet = this.followMap.get(userId) || new Set();
    for (let i = this.tweets.length - 1; i >= 0; i--) {
        const { userId: uId, tweetId } = this.tweets[i];
        if (uId === userId || followSet.has(uId)) {
            result.push(tweetId);
            if (result.length === 10) break;
        }
    }
    return result;
};

Twitter.prototype.follow = function(followerId, followeeId) {
    if (!this.followMap.has(followerId)) {
        this.followMap.set(followerId, new Set());
    }
    this.followMap.get(followerId).add(followeeId);
};

Twitter.prototype.unfollow = function(followerId, followeeId) {
    if (this.followMap.has(followerId)) {
        this.followMap.get(followerId).delete(followeeId);
    }
};