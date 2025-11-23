class Solution {
public:
    int numberOfWays(int n, int x) {
        const int MOD = 1e9 + 7;
        vector<int> dp(n + 1, 0);
        dp[0] = 1;
        for (int a = 1; pow(a, x) <= n; ++a) {
            int num = pow(a, x);
            for (int i = n; i >= num; --i) {
                dp[i] = (dp[i] + dp[i - num]) % MOD;
            }
        }
        return dp[n];
    }
};