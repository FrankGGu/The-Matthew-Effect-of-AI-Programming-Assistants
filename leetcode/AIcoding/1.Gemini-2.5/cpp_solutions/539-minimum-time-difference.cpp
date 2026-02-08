#include <vector>
#include <string>
#include <algorithm>
#include <climits>

class Solution {
public:
    int findMinDifference(std::vector<std::string>& timePoints) {
        if (timePoints.size() > 1440) {
            return 0;
        }

        std::vector<int> minutes;
        minutes.reserve(timePoints.size());
        for (const std::string& tp : timePoints) {
            minutes.push_back(std::stoi(tp.substr(0, 2)) * 60 + std::stoi(tp.substr(3, 2)));
        }

        std::sort(minutes.begin(), minutes.end());

        int minDiff = INT_MAX;
        for (size_t i = 1; i < minutes.size(); ++i) {
            minDiff = std::min(minDiff, minutes[i] - minutes[i - 1]);
        }

        int circularDiff = minutes.front() + 1440 - minutes.back();
        minDiff = std::min(minDiff, circularDiff);

        return minDiff;
    }
};