#include <string>
#include <vector>
#include <map>
#include <set>
#include <algorithm>

class TweetCounts {
public:
    std::map<std::string, std::multiset<int>> tweets;

    TweetCounts() {

    }

    void recordTweet(std::string tweetName, int time) {
        tweets[tweetName].insert(time);
    }

    std::vector<int> getTweetCountsPerFrequency(std::string freq, std::string tweetName, int startTime, int endTime) {
        int intervalSize;
        if (freq == "minute") {
            intervalSize = 60;
        } else if (freq == "hour") {
            intervalSize = 3600;
        } else { // freq == "day"
            intervalSize = 86400;
        }

        int numIntervals = (endTime - startTime) / intervalSize + 1;
        std::vector<int> counts(numIntervals, 0);

        auto it_map = tweets.find(tweetName);
        if (it_map == tweets.end()) {
            return counts;
        }

        const std::multiset<int>& tweetTimes = it_map->second;

        for (auto it = tweetTimes.lower_bound(startTime); it != tweetTimes.end() && *it <= endTime; ++it) {
            int tweetTime = *it;
            int idx = (tweetTime - startTime) / intervalSize;
            counts[idx]++;
        }

        return counts;
    }
};