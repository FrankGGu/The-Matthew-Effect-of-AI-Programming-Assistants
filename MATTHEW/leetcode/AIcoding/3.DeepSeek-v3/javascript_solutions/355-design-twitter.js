var Twitter = function() {
    this.users = new Map();
    this.tweets = [];
    this.timestamp = 0;
};

Twitter.prototype.postTweet = function(userId, tweetId) {
    if (!this.users.has(userId)) {
        this.users.set(userId, new Set());
    }
    this.tweets.push({ userId, tweetId, timestamp: this.timestamp++ });
};

Twitter.prototype.getNewsFeed = function(userId) {
    if (!this.users.has(userId)) return [];
    const following = this.users.get(userId);
    const feed = [];
    let count = 0;
    for (let i = this.tweets.length - 1; i >= 0 && count < 10; i--) {
        const tweet = this.tweets[i];
        if (tweet.userId === userId || following.has(tweet.userId)) {
            feed.push(tweet.tweetId);
            count++;
        }
    }
    return feed;
};

Twitter.prototype.follow = function(followerId, followeeId) {
    if (!this.users.has(followerId)) {
        this.users.set(followerId, new Set());
    }
    this.users.get(followerId).add(followeeId);
};

Twitter.prototype.unfollow = function(followerId, followeeId) {
    if (this.users.has(followerId)) {
        this.users.get(followerId).delete(followeeId);
    }
};