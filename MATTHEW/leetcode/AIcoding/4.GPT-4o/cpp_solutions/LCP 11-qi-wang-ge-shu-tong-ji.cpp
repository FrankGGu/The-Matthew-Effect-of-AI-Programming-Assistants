class Solution {
public:
    double getExpectation(int n, int m) {
        vector<double> dp(n + 1, 0);
        dp[0] = 1.0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m && j <= i; ++j) {
                dp[i] += dp[i - j] / m;
            }
        }

        return dp[n];
    }
};