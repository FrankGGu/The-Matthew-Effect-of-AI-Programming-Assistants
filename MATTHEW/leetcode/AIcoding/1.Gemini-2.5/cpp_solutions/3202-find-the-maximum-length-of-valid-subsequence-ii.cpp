#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumLength(std::vector<int>& nums, int k) {
        int overall_max_len = 0;
        for (int target_rem = 0; target_rem < k; ++target_rem) {
            std::vector<int> dp(k, 0);
            int current_max_for_target = 0;
            for (int num : nums) {
                int rem = num % k;
                int prev_rem = (target_rem - rem + k) % k;
                dp[rem] = 1 + dp[prev_rem];
                current_max_for_target = std::max(current_max_for_target, dp[rem]);
            }
            overall_max_len = std::max(overall_max_len, current_max_for_target);
        }

        return overall_max_len;
    }
};