#include <vector>
#include <algorithm>

class Solution {
public:
    int longestSubsequence(std::vector<int>& nums, int target) {
        std::vector<int> dp(target + 1, -1);
        dp[0] = 0;

        for (int num : nums) {
            for (int s = target; s >= num; --s) {
                if (dp[s - num] != -1) {
                    dp[s] = std::max(dp[s], dp[s - num] + 1);
                }
            }
        }

        return dp[target];
    }
};