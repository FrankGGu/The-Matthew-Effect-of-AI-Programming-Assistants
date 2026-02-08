#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minimumSum(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 3) return 0;

        std::sort(nums.begin(), nums.end());
        int minSum = std::numeric_limits<int>::max();

        for (int i = 0; i < n - 2; ++i) {
            for (int j = i + 1; j < n - 1; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    if (nums[i] < nums[j] && nums[j] > nums[k]) {
                        minSum = std::min(minSum, nums[i] + nums[j] + nums[k]);
                    }
                }
            }
        }

        return minSum == std::numeric_limits<int>::max() ? 0 : minSum;
    }
};