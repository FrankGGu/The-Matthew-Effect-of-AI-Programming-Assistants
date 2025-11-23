#include <vector>
#include <algorithm> // Required for std::sort and std::max

class Solution {
public:
    int maxFreeTime(std::vector<std::vector<int>>& meetings) {
        if (meetings.empty()) {
            return 0;
        }

        std::sort(meetings.begin(), meetings.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[0] < b[0];
        });

        std::vector<std::vector<int>> merged_intervals;
        merged_intervals.push_back(meetings[0]);

        for (size_t i = 1; i < meetings.size(); ++i) {
            std::vector<int>& last_merged = merged_intervals.back();
            const std::vector<int>& current_meeting = meetings[i];

            if (current_meeting[0] <= last_merged[1]) {
                last_merged[1] = std::max(last_merged[1], current_meeting[1]);
            } else {
                merged_intervals.push_back(current_meeting);
            }
        }

        int total_free_time = 0;
        for (size_t i = 1; i < merged_intervals.size(); ++i) {
            total_free_time += (merged_intervals[i][0] - merged_intervals[i-1][1]);
        }

        return total_free_time;
    }
};