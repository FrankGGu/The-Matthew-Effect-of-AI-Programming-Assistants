class Solution {
public:
    int countArrays(int n, int k) {
        const int MOD = 1e9 + 7;
        long long dp[n + 1][k + 1];
        memset(dp, 0, sizeof(dp));

        for (int j = 1; j <= k; j++) {
            dp[1][j] = j;
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j] = (dp[i - 1][j] * (j - 1) + dp[i - 1][j - 1]) % MOD;
            }
        }

        long long res = 0;
        for (int j = 1; j <= k; j++) {
            res = (res + dp[n][j]) % MOD;
        }

        return res;
    }
};