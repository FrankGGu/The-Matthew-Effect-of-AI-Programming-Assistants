class Solution {
public:
    int beautifulPartitions(string s, int k, int minLength) {
        const int MOD = 1e9 + 7;
        int n = s.size();
        if (k * minLength > n) return 0;

        vector<vector<int>> dp(k + 1, vector<int>(n + 1, 0));
        dp[0][0] = 1;

        auto isPrime = [](char c) {
            return c == '2' || c == '3' || c == '5' || c == '7';
        };

        for (int i = 1; i <= k; ++i) {
            for (int j = i * minLength; j <= n; ++j) {
                if (!isPrime(s[j - 1])) {
                    for (int l = (i - 1) * minLength; l <= j - minLength; ++l) {
                        if (isPrime(s[l])) {
                            dp[i][j] = (dp[i][j] + dp[i - 1][l]) % MOD;
                        }
                    }
                }
            }
        }

        return dp[k][n];
    }
};