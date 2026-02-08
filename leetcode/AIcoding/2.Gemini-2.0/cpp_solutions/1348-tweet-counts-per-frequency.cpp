#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class TweetCounts {
public:
    TweetCounts() {

    }

    void recordTweet(string tweetName, int time) {
        tweets[tweetName].push_back(time);
    }

    vector<int> getTweetCountsPerFrequency(string freq, string tweetName, int startTime, int endTime) {
        int interval;
        if (freq == "minute") {
            interval = 60;
        } else if (freq == "hour") {
            interval = 3600;
        } else {
            interval = 86400;
        }

        vector<int> result((endTime - startTime) / interval + 1, 0);
        for (int time : tweets[tweetName]) {
            if (time >= startTime && time <= endTime) {
                result[(time - startTime) / interval]++;
            }
        }
        return result;
    }

private:
    unordered_map<string, vector<int>> tweets;
};