#include <unordered_map>
#include <vector>
#include <string>
#include <set>

class TweetCounts {
private:
    std::unordered_map<std::string, std::multiset<int>> tweetRecords;

public:
    TweetCounts() {

    }

    void recordTweet(const std::string& tweetName, int time) {
        tweetRecords[tweetName].insert(time);
    }

    std::vector<int> getTweetCountsPerFrequency(const std::string& freq, const std::string& tweetName, int startTime, int endTime) {
        int delta = 0;
        if (freq == "minute") {
            delta = 60;
        } else if (freq == "hour") {
            delta = 3600;
        } else if (freq == "day") {
            delta = 86400;
        }

        std::vector<int> result;
        if (tweetRecords.find(tweetName) == tweetRecords.end()) {
            return result;
        }

        const auto& times = tweetRecords[tweetName];
        int currentStart = startTime;
        while (currentStart <= endTime) {
            int currentEnd = std::min(currentStart + delta - 1, endTime);
            auto lower = times.lower_bound(currentStart);
            auto upper = times.upper_bound(currentEnd);
            int count = std::distance(lower, upper);
            result.push_back(count);
            currentStart = currentEnd + 1;
        }

        return result;
    }
};