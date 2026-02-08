#include <vector>
#include <string>
#include <algorithm>
#include <climits>

class Solution {
public:
    int findMinDifference(std::vector<std::string>& timePoints) {
        std::vector<int> minutes;
        for (const std::string& timeStr : timePoints) {
            int hour = std::stoi(timeStr.substr(0, 2));
            int minute = std::stoi(timeStr.substr(3, 2));
            minutes.push_back(hour * 60 + minute);
        }

        std::sort(minutes.begin(), minutes.end());

        int minDiff = INT_MAX;
        for (int i = 0; i < minutes.size() - 1; ++i) {
            minDiff = std::min(minDiff, minutes[i+1] - minutes[i]);
        }

        minDiff = std::min(minDiff, (minutes[0] + 24 * 60) - minutes.back());

        return minDiff;
    }
};