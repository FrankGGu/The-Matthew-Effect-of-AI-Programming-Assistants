#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int maximumJumps(std::vector<int>& nums, int target) {
        int n = nums.size();
        std::vector<int> dp(n, -1);
        dp[0] = 0;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j] != -1) {
                    long long diff = (long long)nums[i] - nums[j];
                    if (std::abs(diff) <= target) {
                        dp[i] = std::max(dp[i], dp[j] + 1);
                    }
                }
            }
        }

        return dp[n - 1];
    }
};