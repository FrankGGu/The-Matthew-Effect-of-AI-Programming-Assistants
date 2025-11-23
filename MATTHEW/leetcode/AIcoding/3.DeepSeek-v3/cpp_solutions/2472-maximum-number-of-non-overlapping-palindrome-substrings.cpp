class Solution {
public:
    int maxPalindromes(string s, int k) {
        int n = s.size();
        vector<vector<bool>> dp(n, vector<bool>(n, false));
        for (int i = 0; i < n; ++i) {
            dp[i][i] = true;
        }
        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == s[i + 1]) {
                dp[i][i + 1] = true;
            }
        }
        for (int len = 3; len <= n; ++len) {
            for (int i = 0; i + len - 1 < n; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j] && dp[i + 1][j - 1]) {
                    dp[i][j] = true;
                }
            }
        }
        vector<int> f(n, 0);
        for (int i = 0; i < n; ++i) {
            if (i > 0) {
                f[i] = f[i - 1];
            }
            for (int j = 0; j <= i - k + 1; ++j) {
                if (dp[j][i]) {
                    f[i] = max(f[i], (j > 0 ? f[j - 1] : 0) + 1);
                    break;
                }
            }
        }
        return f[n - 1];
    }
};