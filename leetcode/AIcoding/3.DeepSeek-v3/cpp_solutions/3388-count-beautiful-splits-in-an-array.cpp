class Solution {
public:
    int beautifulPartitions(string s, int k, int minLength) {
        int n = s.size();
        if (k * minLength > n) return 0;
        const int MOD = 1e9 + 7;

        auto isPrime = [](char c) {
            return c == '2' || c == '3' || c == '5' || c == '7';
        };

        if (!isPrime(s[0]) return 0;

        vector<vector<int>> dp(k + 1, vector<int>(n + 1, 0));
        dp[0][0] = 1;

        for (int parts = 1; parts <= k; ++parts) {
            int sum = 0;
            for (int i = 1; i <= n; ++i) {
                if (i >= minLength) {
                    if (!isPrime(s[i - 1])) {
                        sum = (sum + dp[parts - 1][i - minLength]) % MOD;
                    }
                }
                if (!isPrime(s[i - 1])) {
                    dp[parts][i] = sum;
                }
            }
        }

        return dp[k][n];
    }
};