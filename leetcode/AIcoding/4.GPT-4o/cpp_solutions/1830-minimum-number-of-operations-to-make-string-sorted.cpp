class Solution {
public:
    int minOperations(string s) {
        int n = s.size();
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + (s[i - 1] == '0' ? 1 : 0);
        }
        int minOps = dp[n];
        for (int i = 0; i < n; ++i) {
            minOps = min(minOps, dp[i] + (n - i) - (dp[n] - dp[i]));
        }
        return minOps;
    }
};