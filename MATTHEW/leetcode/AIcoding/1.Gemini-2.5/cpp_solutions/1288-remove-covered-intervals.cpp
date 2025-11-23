#include <vector>
#include <algorithm>

class Solution {
public:
    int removeCoveredIntervals(std::vector<std::vector<int>>& intervals) {
        if (intervals.empty()) {
            return 0;
        }

        std::sort(intervals.begin(), intervals.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[0] != b[0]) {
                return a[0] < b[0];
            }
            return a[1] > b[1];
        });

        int count = 0;
        int max_end = -1;

        for (const auto& interval : intervals) {
            int current_start = interval[0];
            int current_end = interval[1];

            if (current_end > max_end) {
                count++;
                max_end = current_end;
            }
        }

        return count;
    }
};