#include <vector>
#include <numeric> // For std::fill

class Solution {
public:
    int countArrays(int n, int m, int k) {
        long long MOD = 1e9 + 7;

        std::vector<std::vector<int>> dp_prev(m + 1, std::vector<int>(k + 1, 0));
        std::vector<std::vector<int>> dp_curr(m + 1, std::vector<int>(k + 1, 0));

        for (int j = 1; j <= m; ++j) {
            dp_prev[j][0] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                std::fill(dp_curr[j].begin(), dp_curr[j].end(), 0);
            }

            for (int c = 0; c <= k; ++c) {
                long long total_ways_prev_len_same_k = 0;
                for (int prev_j = 1; prev_j <= m; ++prev_j) {
                    total_ways_prev_len_same_k = (total_ways_prev_len_same_k + dp_prev[prev_j][c]) % MOD;
                }

                for (int j = 1; j <= m; ++j) {
                    if (c > 0) {
                        dp_curr[j][c] = (dp_curr[j][c] + dp_prev[j][c-1]) % MOD;
                    }

                    long long term2 = (total_ways_prev_len_same_k - dp_prev[j][c] + MOD) % MOD;
                    dp_curr[j][c] = (dp_curr[j][c] + term2) % MOD;
                }
            }
            std::swap(dp_prev, dp_curr);
        }

        long long ans = 0;
        for (int j = 1; j <= m; ++j) {
            ans = (ans + dp_prev[j][k]) % MOD;
        }

        return static_cast<int>(ans);
    }
};