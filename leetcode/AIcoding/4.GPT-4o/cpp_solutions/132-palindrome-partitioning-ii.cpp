class Solution {
public:
    int minCut(string s) {
        int n = s.size();
        if (n <= 1) return 0;

        vector<int> dp(n + 1);
        for (int i = 0; i <= n; i++) dp[i] = n - 1 - i;

        for (int i = 0; i < n; i++) {
            for (int j = 0; i - j >= 0 && i + j < n && s[i - j] == s[i + j]; j++) {
                dp[i + j + 1] = min(dp[i + j + 1], 1 + dp[i - j]);
            }
            for (int j = 0; i - j >= 0 && i + j + 1 < n && s[i - j] == s[i + j + 1]; j++) {
                dp[i + j + 2] = min(dp[i + j + 2], 1 + dp[i - j]);
            }
        }

        return dp[n];
    }
};