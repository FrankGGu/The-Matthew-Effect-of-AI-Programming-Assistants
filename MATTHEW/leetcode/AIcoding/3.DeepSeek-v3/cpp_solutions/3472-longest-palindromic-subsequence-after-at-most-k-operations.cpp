class Solution {
public:
    int longestPalindromeSubseq(string s, int k) {
        int n = s.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(k + 1, 0)));

        for (int i = 0; i < n; ++i) {
            for (int op = 0; op <= k; ++op) {
                dp[i][i][op] = 1;
            }
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                for (int op = 0; op <= k; ++op) {
                    if (s[i] == s[j]) {
                        dp[i][j][op] = 2 + (len == 2 ? 0 : dp[i + 1][j - 1][op]);
                    } else {
                        int res = 0;
                        if (len > 2) {
                            res = max(dp[i + 1][j][op], dp[i][j - 1][op]);
                        }
                        if (op > 0) {
                            res = max(res, 2 + (len == 2 ? 0 : dp[i + 1][j - 1][op - 1]));
                        }
                        dp[i][j][op] = res;
                    }
                }
            }
        }

        return dp[0][n - 1][k];
    }
};