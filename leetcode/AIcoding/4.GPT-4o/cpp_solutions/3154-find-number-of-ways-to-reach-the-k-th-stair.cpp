class Solution {
public:
    int countWays(int n, int k) {
        if (n == 0) return 1;
        if (n < 0) return 0;

        int mod = 1e9 + 7;
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                if (i - j >= 0) {
                    dp[i] = (dp[i] + dp[i - j]) % mod;
                }
            }
        }
        return dp[n];
    }
};