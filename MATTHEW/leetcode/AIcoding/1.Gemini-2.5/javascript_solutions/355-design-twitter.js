var Twitter = function() {
    this.tweets = new Map(); // Map<userId, Array<{tweetId: number, time: number}>>
    this.followers = new Map(); // Map<followerId, Set<followeeId>>
    this.time = 0; // Global timestamp counter
};

Twitter.prototype.postTweet = function(userId, tweetId) {
    this.time++;
    if (!this.tweets.has(userId)) {
        this.tweets.set(userId, []);
    }
    this.tweets.get(userId).push({tweetId: tweetId, time: this.time});
};

Twitter.prototype.getNewsFeed = function(userId) {
    const usersToCheck = new Set();
    usersToCheck.add(userId); // A user's news feed includes their own tweets

    if (this.followers.has(userId)) {
        for (const followeeId of this.followers.get(userId)) {
            usersToCheck.add(followeeId);
        }
    }

    const allRelevantTweets = [];
    for (const uId of usersToCheck) {
        if (this.tweets.has(uId)) {
            allRelevantTweets.push(...this.tweets.get(uId));
        }
    }

    allRelevantTweets.sort((a, b) => b.time - a.time); // Sort by time descending

    return allRelevantTweets.slice(0, 10).map(tweet => tweet.tweetId);
};

Twitter.prototype.follow = function(followerId, followeeId) {
    if (!this.followers.has(followerId)) {
        this.followers.set(followerId, new Set());
    }
    this.followers.get(followerId).add(followeeId);
};

Twitter.prototype.unfollow = function(followerId, followeeId) {
    if (this.followers.has(followerId)) {
        this.followers.get(followerId).delete(followeeId);
    }
};