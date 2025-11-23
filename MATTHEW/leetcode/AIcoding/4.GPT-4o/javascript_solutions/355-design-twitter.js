class Twitter {
    constructor() {
        this.time = 0;
        this.tweets = {};
        this.followings = {};
    }

    postTweet(userId, tweetId) {
        if (!this.tweets[userId]) {
            this.tweets[userId] = [];
        }
        this.tweets[userId].push({ tweetId, time: this.time++ });
    }

    getNewsFeed(userId) {
        const feed = [];
        const users = this.followings[userId] || new Set();
        users.add(userId);
        for (const user of users) {
            if (this.tweets[user]) {
                for (const tweet of this.tweets[user]) {
                    feed.push(tweet);
                }
            }
        }
        feed.sort((a, b) => b.time - a.time);
        return feed.slice(0, 10).map(tweet => tweet.tweetId);
    }

    follow(followerId, followeeId) {
        if (!this.followings[followerId]) {
            this.followings[followerId] = new Set();
        }
        this.followings[followerId].add(followeeId);
    }

    unfollow(followerId, followeeId) {
        if (this.followings[followerId]) {
            this.followings[followerId].delete(followeeId);
        }
    }
}