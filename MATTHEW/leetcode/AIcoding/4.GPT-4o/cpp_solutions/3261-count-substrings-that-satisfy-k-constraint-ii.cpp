class Solution {
public:
    int countSubstrings(string s, string t) {
        int m = s.size(), n = t.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                dp[i][j] = dp[i - 1][j - 1] + (s[i - 1] != t[j - 1]);
            }
        }

        vector<int> count(m + 1, 0);
        for (int j = 0; j <= n; ++j) {
            for (int i = 0; i <= m; ++i) {
                if (dp[i][j] <= 1) count[i]++;
            }
        }

        int result = 0;
        for (int i = 0; i <= m; ++i) {
            result += count[i];
        }

        return result;
    }
};