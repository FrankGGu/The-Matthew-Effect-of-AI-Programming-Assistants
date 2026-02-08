class Solution {
public:
    int countPalindromicSubsequences(string S) {
        int n = S.size();
        int MOD = 1e9 + 7;
        vector<vector<int>> dp(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) dp[i][i] = 1;

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i < n - len + 1; ++i) {
                int j = i + len - 1;
                if (S[i] == S[j]) {
                    int left = i + 1, right = j - 1;
                    while (left <= right && S[left] != S[i]) ++left;
                    while (left <= right && S[right] != S[i]) --right;
                    if (left > right) {
                        dp[i][j] = dp[i+1][j-1] * 2 + 2;
                    } else if (left == right) {
                        dp[i][j] = dp[i+1][j-1] * 2 + 1;
                    } else {
                        dp[i][j] = dp[i+1][j-1] * 2 - dp[left+1][right-1];
                    }
                } else {
                    dp[i][j] = dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1];
                }
                dp[i][j] = dp[i][j] < 0 ? dp[i][j] + MOD : dp[i][j] % MOD;
            }
        }
        return dp[0][n-1];
    }
};