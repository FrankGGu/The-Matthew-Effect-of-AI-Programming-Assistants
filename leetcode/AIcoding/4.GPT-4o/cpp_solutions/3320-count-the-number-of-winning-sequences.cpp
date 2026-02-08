class Solution {
public:
    int countWinningSequences(int n) {
        vector<long> dp(n + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                dp[i] = (dp[i] + dp[j] * dp[i - 1 - j]) % 1000000007;
            }
        }
        return dp[n];
    }
};