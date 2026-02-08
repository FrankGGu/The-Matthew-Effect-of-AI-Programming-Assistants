class Solution {
public:
    int countPalindromicSubsequences(string s) {
        int n = s.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (i == j) {
                    dp[i][j] = 1;
                } else if (s[i] == s[j]) {
                    int low = i + 1, high = j - 1;
                    while (low <= high && s[low] != s[i]) low++;
                    while (low <= high && s[high] != s[j]) high--;
                    if (low > high) {
                        dp[i][j] = dp[i + 1][j - 1] + 2;
                    } else if (low == high) {
                        dp[i][j] = dp[i + 1][j - 1] + 1;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] - dp[low + 1][high - 1] + 2;
                    }
                } else {
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
                }
            }
        }

        return dp[0][n - 1];
    }
};