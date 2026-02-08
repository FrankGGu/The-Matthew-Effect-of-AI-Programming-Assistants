#include <vector>
#include <algorithm>

class Solution {
public:
    int smallestRangeII(std::vector<int>& nums, int k) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        std::sort(nums.begin(), nums.end());

        int res = nums[n - 1] - nums[0];

        for (int i = 0; i < n - 1; ++i) {
            int high = std::max(nums[i] + k, nums[n - 1] - k);
            int low = std::min(nums[0] + k, nums[i + 1] - k);
            res = std::min(res, high - low);
        }

        return res;
    }
};