class Solution {
public:
    int minimumChanges(string s, int k) {
        int n = s.size();
        if (k > n) return -1;
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                for (int len = 1; len <= min(i, 2 * j); ++len) {
                    int changes = 0;
                    for (int m = 0; m < len / 2; ++m) {
                        if (s[i - len + m] != s[i - len + len - 1 - m]) {
                            changes++;
                        }
                    }
                    dp[i][j] = min(dp[i][j], dp[i - len][j - 1] + changes);
                }
            }
        }
        return dp[n][k] == INT_MAX ? -1 : dp[n][k];
    }
};