class Solution {
public:
    int numOfArrays(int n, int m, int k) {
        const int MOD = 1e9 + 7;
        if (k == 0 || k > m) return 0;

        vector<vector<vector<long long>>> dp(n + 1, vector<vector<long long>>(m + 1, vector<long long>(k + 1, 0)));

        for (int j = 1; j <= m; ++j) {
            dp[1][j][1] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                for (int l = 1; l <= k; ++l) {
                    long long sum = 0;
                    sum = (sum + dp[i - 1][j][l] * j) % MOD;

                    for (int prev = 1; prev < j; ++prev) {
                        sum = (sum + dp[i - 1][prev][l - 1]) % MOD;
                    }
                    dp[i][j][l] = sum;
                }
            }
        }

        long long res = 0;
        for (int j = 1; j <= m; ++j) {
            res = (res + dp[n][j][k]) % MOD;
        }
        return res;
    }
};