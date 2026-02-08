#include <vector>
#include <numeric>

class Solution {
public:
    int combinationSum4(std::vector<int>& nums, int target) {
        std::vector<unsigned int> dp(target + 1, 0); // Use unsigned int as the problem guarantees the answer fits in a 32-bit integer, and unsigned int provides a larger positive range.
        dp[0] = 1; // There is one way to make a sum of 0 (by choosing no numbers).

        for (int i = 1; i <= target; ++i) {
            for (int num : nums) {
                if (i - num >= 0) {
                    dp[i] += dp[i - num];
                }
            }
        }

        return dp[target];
    }
};