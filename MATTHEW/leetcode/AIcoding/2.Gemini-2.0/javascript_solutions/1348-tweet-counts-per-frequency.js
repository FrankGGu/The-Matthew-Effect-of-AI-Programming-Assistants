var TweetCounts = function() {
    this.tweets = {};
};

TweetCounts.prototype.recordTweet = function(tweetName, time) {
    if (!this.tweets[tweetName]) {
        this.tweets[tweetName] = [];
    }
    this.tweets[tweetName].push(time);
    this.tweets[tweetName].sort((a, b) => a - b);
};

TweetCounts.prototype.getTweetCountsPerFrequency = function(freq, tweetName, startTime, endTime) {
    let interval;
    if (freq === "minute") {
        interval = 60;
    } else if (freq === "hour") {
        interval = 3600;
    } else {
        interval = 86400;
    }

    let result = [];
    let count = 0;
    let start = startTime;
    let end = startTime + interval;

    while (start <= endTime) {
        count = 0;
        if (this.tweets[tweetName]) {
            for (let time of this.tweets[tweetName]) {
                if (time >= start && time < end) {
                    count++;
                }
            }
        }
        result.push(count);
        start = end;
        end = Math.min(end + interval, endTime + 1);
    }

    return result;
};