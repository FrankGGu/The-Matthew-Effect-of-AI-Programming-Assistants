#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int maxCircularAdjacentDifference(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 2) {
            return 0;
        }

        int max_diff = 0;
        for (int i = 0; i < n; ++i) {
            max_diff = std::max(max_diff, std::abs(nums[i] - nums[(i + 1) % n]));
        }

        return max_diff;
    }
};