#include <vector>

class Solution {
public:
    int numberOfStableArrays(int zero, int one, int limit) {
        int MOD = 1e9 + 7;

        std::vector<std::vector<std::vector<long long>>> dp(zero + 1, std::vector<std::vector<long long>>(one + 1, std::vector<long long>(2, 0)));

        for (int i = 1; i <= std::min(zero, limit); ++i) {
            dp[i][0][0] = 1;
        }
        for (int j = 1; j <= std::min(one, limit); ++j) {
            dp[0][j][1] = 1;
        }

        for (int i = 1; i <= zero; ++i) {
            for (int j = 1; j <= one; ++j) {
                long long ends_in_zero_sum = (dp[i - 1][j][0] + dp[i - 1][j][1]) % MOD;
                if (i > limit) {
                    ends_in_zero_sum = (ends_in_zero_sum - dp[i - limit - 1][j][1] + MOD) % MOD;
                }
                dp[i][j][0] = ends_in_zero_sum;

                long long ends_in_one_sum = (dp[i][j - 1][0] + dp[i][j - 1][1]) % MOD;
                if (j > limit) {
                    ends_in_one_sum = (ends_in_one_sum - dp[i][j - limit - 1][0] + MOD) % MOD;
                }
                dp[i][j][1] = ends_in_one_sum;
            }
        }

        return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
    }
};