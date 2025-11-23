var TweetCounts = function() {
    this.tweets = {};
};

TweetCounts.prototype.recordTweet = function(tweetName, time) {
    if (!this.tweets[tweetName]) {
        this.tweets[tweetName] = [];
    }
    this.tweets[tweetName].push(time);
};

TweetCounts.prototype.getTweetCountsPerFrequency = function(freq, tweetName, startTime, endTime) {
    if (!this.tweets[tweetName]) {
        return [];
    }
    const times = this.tweets[tweetName];
    let delta;
    if (freq === 'minute') {
        delta = 60;
    } else if (freq === 'hour') {
        delta = 3600;
    } else {
        delta = 86400;
    }
    const res = [];
    let currentStart = startTime;
    while (currentStart <= endTime) {
        const currentEnd = Math.min(currentStart + delta - 1, endTime);
        let count = 0;
        for (const time of times) {
            if (time >= currentStart && time <= currentEnd) {
                count++;
            }
        }
        res.push(count);
        currentStart = currentStart + delta;
    }
    return res;
};