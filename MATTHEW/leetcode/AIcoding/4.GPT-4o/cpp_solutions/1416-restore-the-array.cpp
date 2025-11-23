class Solution {
public:
    int countArrangements(string s) {
        int mod = 1e9 + 7;
        int n = s.size();
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= 9; ++j) {
                if (s[i - 1] == '?' || s[i - 1] - '0' == j) {
                    dp[i] = (dp[i] + dp[i - 1] * (j <= i ? 1 : 0)) % mod;
                }
            }
        }

        return dp[n];
    }
};