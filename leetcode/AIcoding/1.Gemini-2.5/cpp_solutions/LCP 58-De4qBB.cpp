#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long minCostToMergeBlocks(std::vector<int>& blocks) {
        int n = blocks.size();
        if (n <= 1) {
            return 0;
        }

        std::vector<std::vector<long long>> dp(n, std::vector<long long>(n, 0));
        std::vector<long long> prefix_sum(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + blocks[i];
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                dp[i][j] = LLONG_MAX;

                long long current_merge_cost = prefix_sum[j + 1] - prefix_sum[i];

                for (int k = i; k < j; ++k) {
                    if (dp[i][k] != LLONG_MAX && dp[k+1][j] != LLONG_MAX) {
                         dp[i][j] = std::min(dp[i][j], dp[i][k] + dp[k+1][j] + current_merge_cost);
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
};