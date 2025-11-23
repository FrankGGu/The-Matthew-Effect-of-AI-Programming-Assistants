#include <vector>
#include <set>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minAbsoluteDifference(std::vector<int>& nums, int x) {
        int n = nums.size();
        int min_diff = INT_MAX;

        std::set<int> seen_elements;

        for (int j = x; j < n; ++j) {
            seen_elements.insert(nums[j - x]);

            auto it = seen_elements.lower_bound(nums[j]);

            if (it != seen_elements.end()) {
                min_diff = std::min(min_diff, std::abs(nums[j] - *it));
            }

            if (it != seen_elements.begin()) {
                --it;
                min_diff = std::min(min_diff, std::abs(nums[j] - *it));
            }
        }

        return min_diff;
    }
};