class Solution {
public:
    int numberOfSets(int n, int k) {
        const int MOD = 1e9 + 7;
        vector<vector<long long>> dp(n + 1, vector<long long>(k + 1, 0));
        vector<vector<long long>> prefix(n + 1, vector<long long>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            dp[i][0] = 1;
            prefix[i][0] = prefix[i-1][0] + dp[i][0];
        }

        for (int j = 1; j <= k; ++j) {
            for (int i = 2; i <= n; ++i) {
                dp[i][j] = (dp[i-1][j] + prefix[i-1][j-1]) % MOD;
                prefix[i][j] = (prefix[i-1][j] + dp[i][j]) % MOD;
            }
        }

        return dp[n][k];
    }
};