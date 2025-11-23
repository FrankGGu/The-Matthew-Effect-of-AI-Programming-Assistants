var TweetCounts = function() {
    this.tweets = new Map();
};

TweetCounts.prototype.recordTweet = function(tweetName, time) {
    if (!this.tweets.has(tweetName)) {
        this.tweets.set(tweetName, []);
    }
    this.tweets.get(tweetName).push(time);
};

TweetCounts.prototype.getTweetCountsPerFrequency = function(freq, startTime, endTime) {
    const result = new Map();
    const interval = freq === 'second' ? 1 : freq === 'minute' ? 60 : 3600;
    const times = this.tweets.get(freq) || [];

    for (let t = startTime; t <= endTime; t += interval) {
        const end = Math.min(t + interval, endTime + 1);
        let count = 0;
        for (let i = 0; i < times.length; i++) {
            if (times[i] >= t && times[i] < end) {
                count++;
            }
        }
        result.set(t, count);
    }

    return Array.from(result.entries()).map(([time, count]) => [time, count]);
};