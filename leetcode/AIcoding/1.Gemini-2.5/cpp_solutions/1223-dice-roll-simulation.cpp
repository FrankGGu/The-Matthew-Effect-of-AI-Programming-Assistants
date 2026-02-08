#include <vector>
#include <numeric>

class Solution {
public:
    int dieSimulator(int n, std::vector<int>& rollMax) {
        long long MOD = 1e9 + 7;

        std::vector<std::vector<long long>> dp(n + 1, std::vector<long long>(6, 0));
        std::vector<long long> S(n + 1, 0);

        S[0] = 1;

        for (int j = 0; j < 6; ++j) {
            dp[1][j] = 1;
        }
        S[1] = 6;

        for (int i = 2; i <= n; ++i) {
            for (int j = 0; j < 6; ++j) {
                dp[i][j] = S[i-1];

                if (i - 1 - rollMax[j] >= 0) {
                    long long to_subtract = (S[i - 1 - rollMax[j]] - dp[i - 1 - rollMax[j]][j] + MOD) % MOD;
                    dp[i][j] = (dp[i][j] - to_subtract + MOD) % MOD;
                }
            }
            for (int j = 0; j < 6; ++j) {
                S[i] = (S[i] + dp[i][j]) % MOD;
            }
        }

        return S[n];
    }
};