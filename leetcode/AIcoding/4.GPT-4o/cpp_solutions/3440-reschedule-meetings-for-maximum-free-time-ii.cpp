#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    int maxFreeTime(std::vector<std::vector<int>>& intervals) {
        std::set<std::pair<int, int>> meetings;
        for (const auto& interval : intervals) {
            meetings.insert({interval[0], interval[1]});
        }

        std::vector<std::pair<int, int>> merged;
        for (const auto& meeting : meetings) {
            if (merged.empty() || merged.back().second < meeting.first) {
                merged.push_back(meeting);
            } else {
                merged.back().second = std::max(merged.back().second, meeting.second);
            }
        }

        int maxFreeTime = 0;
        for (size_t i = 1; i < merged.size(); ++i) {
            maxFreeTime = std::max(maxFreeTime, merged[i].first - merged[i - 1].second);
        }

        return maxFreeTime;
    }
};