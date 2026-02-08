class Solution {
public:
    int numPermsDISequence(string S) {
        int n = S.size(), mod = 1e9 + 7;
        vector<vector<int>> dp(n + 1, vector<int>(n + 1));
        for (int j = 0; j <= n; ++j) dp[0][j] = 1;
        for (int i = 0; i < n; ++i) {
            if (S[i] == 'I') {
                for (int j = 0, cur = 0; j < n - i; ++j) {
                    cur = (cur + dp[i][j]) % mod;
                    dp[i + 1][j] = cur;
                }
            } else {
                for (int j = n - i - 1, cur = 0; j >= 0; --j) {
                    cur = (cur + dp[i][j + 1]) % mod;
                    dp[i + 1][j] = cur;
                }
            }
        }
        return dp[n][0];
    }
};