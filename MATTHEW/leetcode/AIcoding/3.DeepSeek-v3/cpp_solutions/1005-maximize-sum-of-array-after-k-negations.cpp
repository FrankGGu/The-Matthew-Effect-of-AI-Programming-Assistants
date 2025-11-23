#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int largestSumAfterKNegations(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        for (int i = 0; i < nums.size() && k > 0 && nums[i] < 0; ++i, --k) {
            nums[i] = -nums[i];
        }
        if (k % 2 == 1) {
            auto min_it = std::min_element(nums.begin(), nums.end());
            *min_it = -(*min_it);
        }
        return std::accumulate(nums.begin(), nums.end(), 0);
    }
};