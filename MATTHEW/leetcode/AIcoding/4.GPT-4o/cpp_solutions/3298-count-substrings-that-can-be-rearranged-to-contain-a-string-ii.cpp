class Solution {
public:
    int countSubstrings(string s, string t) {
        int m = s.size(), n = t.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));
        vector<vector<int>> count(m + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (s[i - 1] == t[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                }
                count[i][j] = count[i - 1][j] + count[i][j - 1] - count[i - 1][j - 1] + (dp[i][j] == 0);
            }
        }

        int result = 0;
        for (int i = 0; i <= m; ++i) {
            for (int j = 0; j <= n; ++j) {
                result += count[i][j];
            }
        }

        return result;
    }
};