class Solution {
public:
    int palindromePartition(string s, int k) {
        int n = s.size();
        vector<vector<int>> cost(n, vector<int>(n, 0));
        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i + len - 1 < n; ++i) {
                int j = i + len - 1;
                cost[i][j] = cost[i + 1][j - 1] + (s[i] != s[j] ? 1 : 0);
            }
        }

        vector<vector<int>> dp(n + 1, vector<int>(k + 1, INT_MAX / 2));
        dp[0][0] = 0;
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= min(k, i); ++j) {
                if (j == 1) {
                    dp[i][j] = cost[0][i - 1];
                } else {
                    for (int m = j - 1; m < i; ++m) {
                        dp[i][j] = min(dp[i][j], dp[m][j - 1] + cost[m][i - 1]);
                    }
                }
            }
        }
        return dp[n][k];
    }
};