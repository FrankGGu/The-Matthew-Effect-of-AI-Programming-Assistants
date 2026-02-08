class Twitter {
    constructor() {
        this.tweets = [];
        this.followees = new Map();
        this.timestamp = 0;
    }

    postTweet(userId, tweetId) {
        this.tweets.push({ userId, tweetId, timestamp: this.timestamp++ });
    }

    getNewsFeed(userId) {
        const followees = this.followees.get(userId) || new Set([userId]);
        followees.add(userId);

        const newsFeed = this.tweets
            .filter(tweet => followees.has(tweet.userId))
            .sort((a, b) => b.timestamp - a.timestamp)
            .slice(0, 10)
            .map(tweet => tweet.tweetId);

        return newsFeed;
    }

    follow(followerId, followeeId) {
        if (!this.followees.has(followerId)) {
            this.followees.set(followerId, new Set());
        }
        this.followees.get(followerId).add(followeeId);
    }

    unfollow(followerId, followeeId) {
        if (this.followees.has(followerId)) {
            this.followees.get(followerId).delete(followeeId);
        }
    }
}