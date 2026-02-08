class Solution {
public:
    int deleteString(string s) {
        int n = s.size();
        vector<vector<int>> lcp(n + 1, vector<int>(n + 1, 0));
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (s[i] == s[j]) {
                    lcp[i][j] = 1 + lcp[i + 1][j + 1];
                }
            }
        }

        vector<int> dp(n, 1);
        for (int i = n - 1; i >= 0; --i) {
            for (int j = 1; i + 2 * j <= n; ++j) {
                if (lcp[i][i + j] >= j) {
                    dp[i] = max(dp[i], 1 + dp[i + j]);
                }
            }
        }
        return dp[0];
    }
};