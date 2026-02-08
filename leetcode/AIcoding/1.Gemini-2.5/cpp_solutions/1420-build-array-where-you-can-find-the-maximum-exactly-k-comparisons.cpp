#include <vector>
#include <numeric>

class Solution {
public:
    int numOfArrays(int n, int m, int k) {
        long long MOD = 1e9 + 7;

        std::vector<std::vector<std::vector<long long>>> dp(n + 1, 
                                                             std::vector<std::vector<long long>>(m + 1, 
                                                                                                  std::vector<long long>(k + 1, 0)));

        for (int j = 1; j <= m; ++j) {
            dp[1][j][1] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int c = 1; c <= k; ++c) {
                long long sum_prev_max_vals = 0; 
                for (int j = 1; j <= m; ++j) {
                    if (c > 1) {
                        dp[i][j][c] = (dp[i][j][c] + sum_prev_max_vals) % MOD;
                    }

                    dp[i][j][c] = (dp[i][j][c] + (dp[i-1][j][c] * j) % MOD) % MOD;

                    if (c > 1) {
                        sum_prev_max_vals = (sum_prev_max_vals + dp[i-1][j][c-1]) % MOD;
                    }
                }
            }
        }

        long long total_ways = 0;
        for (int j = 1; j <= m; ++j) {
            total_ways = (total_ways + dp[n][j][k]) % MOD;
        }

        return static_cast<int>(total_ways);
    }
};