var TweetCounts = function() {
    this.tweets = new Map(); // Map<tweetName, {times: number[], sorted: boolean}>
};

TweetCounts.prototype.recordTweet = function(tweetName, time) {
    if (!this.tweets.has(tweetName)) {
        this.tweets.set(tweetName, { times: [], sorted: true }); 
    }
    const tweetData = this.tweets.get(tweetName);
    tweetData.times.push(time);
    tweetData.sorted = false; 
};

TweetCounts.prototype.getTweetCountsPerFrequency = function(freq, tweetName, startTime, endTime) {
    if (!this.tweets.has(tweetName)) {
        return [];
    }

    const tweetData = this.tweets.get(tweetName);
    const times = tweetData.times;

    if (!tweetData.sorted) {
        times.sort((a, b) => a - b);
        tweetData.sorted = true;
    }

    let interval;
    switch (freq) {
        case "minute":
            interval = 60;
            break;
        case "hour":
            interval = 3600;
            break;
        case "day":
            interval = 86400;
            break;
    }

    const numBuckets = Math.floor((endTime - startTime) / interval) + 1;
    const result = new Array(numBuckets).fill(0);

    // Helper for lower_bound (first element >= target)
    const lowerBound = (arr, target) => {
        let low = 0, high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    };

    // Helper for upperBound (first element > target)
    const upperBound = (arr, target) => {
        let low = 0, high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] <= target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    };

    // Optimized iteration using binary search to find the range of relevant tweets
    const startIndex = lowerBound(times, startTime);
    const endIndex = upperBound(times, endTime); 

    for (let i = startIndex; i < endIndex; i++) {
        const time = times[i];
        const bucketIndex = Math.floor((time - startTime) / interval);
        result[bucketIndex]++;
    }

    return result;
};