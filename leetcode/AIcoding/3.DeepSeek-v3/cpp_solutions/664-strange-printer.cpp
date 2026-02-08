class Solution {
public:
    int strangePrinter(string s) {
        int n = s.size();
        if (n == 0) return 0;
        vector<vector<int>> dp(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }
        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                dp[i][j] = len;
                for (int k = i; k < j; ++k) {
                    int total = dp[i][k] + dp[k+1][j];
                    if (s[k] == s[j]) {
                        total--;
                    }
                    dp[i][j] = min(dp[i][j], total);
                }
            }
        }
        return dp[0][n-1];
    }
};