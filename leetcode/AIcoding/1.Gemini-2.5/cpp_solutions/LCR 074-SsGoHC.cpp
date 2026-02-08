#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> merge(std::vector<std::vector<int>>& intervals) {
        if (intervals.empty()) {
            return {};
        }

        std::sort(intervals.begin(), intervals.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[0] < b[0];
        });

        std::vector<std::vector<int>> merged;
        merged.push_back(intervals[0]);

        for (size_t i = 1; i < intervals.size(); ++i) {
            std::vector<int>& lastMerged = merged.back();
            const std::vector<int>& current = intervals[i];

            if (current[0] <= lastMerged[1]) {
                lastMerged[1] = std::max(lastMerged[1], current[1]);
            } else {
                merged.push_back(current);
            }
        }

        return merged;
    }
};