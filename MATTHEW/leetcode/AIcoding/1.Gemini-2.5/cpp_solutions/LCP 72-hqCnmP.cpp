#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int supplyWagon(std::vector<int>& power) {
        int n = power.size();
        if (n == 0) {
            return 0;
        }

        long long total_sum = 0;
        for (int p : power) {
            total_sum += p;
        }

        std::vector<long long> prefix_sum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + power[i];
        }

        std::vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];

            for (int k = 1; k <= i; ++k) {
                long long current_team_sum = prefix_sum[i] - prefix_sum[i - k];

                if (static_cast<long long>(n) * current_team_sum <= static_cast<long long>(k) * total_sum) {
                    dp[i] = std::max(dp[i], dp[i - k] + 1);
                }
            }
        }

        return dp[n];
    }
};