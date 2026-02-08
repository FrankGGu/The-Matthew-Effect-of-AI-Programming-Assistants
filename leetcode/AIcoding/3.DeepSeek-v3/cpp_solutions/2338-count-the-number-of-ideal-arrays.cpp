class Solution {
public:
    int idealArrays(int n, int maxValue) {
        const int MOD = 1e9 + 7;
        vector<vector<long long>> dp(maxValue + 1, vector<long long>(15, 0));

        for (int i = 1; i <= maxValue; ++i) {
            dp[i][1] = 1;
        }

        for (int len = 1; len < 14; ++len) {
            for (int i = 1; i <= maxValue; ++i) {
                if (dp[i][len] == 0) continue;
                for (int j = 2 * i; j <= maxValue; j += i) {
                    dp[j][len + 1] = (dp[j][len + 1] + dp[i][len]) % MOD;
                }
            }
        }

        vector<vector<long long>> comb(n + 1, vector<long long>(15, 0));
        comb[0][0] = 1;
        for (int i = 1; i <= n; ++i) {
            comb[i][0] = 1;
            for (int j = 1; j <= min(i, 14); ++j) {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % MOD;
            }
        }

        long long result = 0;
        for (int i = 1; i <= maxValue; ++i) {
            for (int len = 1; len <= 14; ++len) {
                result = (result + dp[i][len] * comb[n - 1][len - 1]) % MOD;
            }
        }

        return result;
    }
};