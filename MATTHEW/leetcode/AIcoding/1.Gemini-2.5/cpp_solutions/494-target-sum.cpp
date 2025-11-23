#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    int findTargetSumWays(std::vector<int>& nums, int target) {
        int sum_nums = 0;
        for (int num : nums) {
            sum_nums += num;
        }

        if (std::abs(target) > sum_nums || (sum_nums + target) % 2 != 0) {
            return 0;
        }

        int target_sum_p = (sum_nums + target) / 2;

        std::vector<int> dp(target_sum_p + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = target_sum_p; j >= num; --j) {
                dp[j] += dp[j - num];
            }
        }

        return dp[target_sum_p];
    }
};