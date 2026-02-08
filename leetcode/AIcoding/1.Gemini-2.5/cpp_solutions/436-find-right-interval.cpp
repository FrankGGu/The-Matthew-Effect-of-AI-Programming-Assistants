#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<int> findRightInterval(std::vector<std::vector<int>>& intervals) {
        int n = intervals.size();
        std::vector<int> result(n);

        if (n == 0) {
            return result;
        }

        std::vector<std::pair<int, int>> indexed_starts;
        indexed_starts.reserve(n);

        for (int i = 0; i < n; ++i) {
            indexed_starts.push_back({intervals[i][0], i});
        }

        std::sort(indexed_starts.begin(), indexed_starts.end());

        for (int i = 0; i < n; ++i) {
            int current_end = intervals[i][1];

            auto it = std::lower_bound(indexed_starts.begin(), indexed_starts.end(), std::make_pair(current_end, -1));

            if (it == indexed_starts.end()) {
                result[i] = -1;
            } else {
                result[i] = it->second;
            }
        }

        return result;
    }
};