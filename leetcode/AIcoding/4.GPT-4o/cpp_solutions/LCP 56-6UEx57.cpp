class Solution {
public:
    int countMessages(string message) {
        int n = message.size();
        if (n == 0) return 0;

        long long MOD = 1e9 + 7;
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];
            if (i > 1 && (message[i - 1] == '1' || (message[i - 1] == '2' && message[i - 2] < '7'))) {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
            }
        }
        return dp[n];
    }
};