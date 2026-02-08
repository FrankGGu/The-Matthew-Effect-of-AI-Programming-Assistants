class TweetCounts {
public:
    unordered_map<string, vector<int>> tweets;
    TweetCounts() {}

    void recordTweet(string tweetName, int time) {
        tweets[tweetName].push_back(time);
    }

    vector<int> getTweetCountsPerFrequency(string freq, string tweetName, int startTime, int endTime) {
        vector<int> result;
        if (tweets.find(tweetName) == tweets.end()) {
            return result;
        }
        vector<int>& times = tweets[tweetName];
        int interval = 0;

        if (freq == "minute") {
            interval = 60;
        } else if (freq == "hour") {
            interval = 3600;
        } else if (freq == "day") {
            interval = 86400;
        }

        int buckets = (endTime - startTime) / interval + 1;
        vector<int> counts(buckets, 0);

        for (int time : times) {
            if (time >= startTime && time <= endTime) {
                counts[(time - startTime) / interval]++;
            }
        }

        return counts;
    }
};