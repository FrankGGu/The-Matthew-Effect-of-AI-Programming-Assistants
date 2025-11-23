class TweetCounts {
    constructor() {
        this.tweets = {};
        this.freqs = { "minute": 60, "hour": 3600, "day": 86400 };
    }

    recordTweet(tweetName, time) {
        if (!this.tweets[tweetName]) {
            this.tweets[tweetName] = [];
        }
        this.tweets[tweetName].push(time);
    }

    getTweetCountsPerFrequency(freq, tweetName, startTime, endTime) {
        const interval = this.freqs[freq];
        const counts = new Array(Math.ceil((endTime - startTime) / interval)).fill(0);
        if (!this.tweets[tweetName]) return counts;

        for (const time of this.tweets[tweetName]) {
            if (time >= startTime && time <= endTime) {
                const index = Math.floor((time - startTime) / interval);
                counts[index]++;
            }
        }
        return counts;
    }
}