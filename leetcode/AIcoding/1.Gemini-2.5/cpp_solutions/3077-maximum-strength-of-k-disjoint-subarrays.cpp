#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long maximumStrength(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        const long long NEG_INF = -4e18; 

        std::vector<long long> prev_dp(n + 1, 0);

        for (int j = 1; j <= k; ++j) {
            std::vector<long long> dp(n + 1, NEG_INF);
            long long w = (long long)j * (j % 2 == 1 ? 1 : -1);
            long long max_term = NEG_INF;

            for (int i = 1; i <= n; ++i) {
                max_term = std::max(max_term, prev_dp[i - 1] - prefix[i - 1] * w);

                dp[i] = dp[i - 1];

                if (max_term != NEG_INF) {
                    dp[i] = std::max(dp[i], max_term + prefix[i] * w);
                }
            }
            prev_dp = dp;
        }

        return prev_dp[n];
    }
};