class Solution {
public:
    int numDecodings(string s) {
        long long n = s.size();
        long long mod = 1e9 + 7;
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;
        dp[1] = (s[0] == '*') ? 9 : (s[0] == '0' ? 0 : 1);

        for (int i = 2; i <= n; ++i) {
            if (s[i - 1] == '*') {
                dp[i] = (dp[i] + 9 * dp[i - 1]) % mod;
            } else if (s[i - 1] != '0') {
                dp[i] = (dp[i] + dp[i - 1]) % mod;
            }

            if (s[i - 2] == '*') {
                if (s[i - 1] == '*') {
                    dp[i] = (dp[i] + 15 * dp[i - 2]) % mod;
                } else if (s[i - 1] <= '6') {
                    dp[i] = (dp[i] + 2 * dp[i - 2]) % mod;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % mod;
                }
            } else if (s[i - 2] == '1') {
                if (s[i - 1] == '*') {
                    dp[i] = (dp[i] + 9 * dp[i - 2]) % mod;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % mod;
                }
            } else if (s[i - 2] == '2') {
                if (s[i - 1] == '*') {
                    dp[i] = (dp[i] + 6 * dp[i - 2]) % mod;
                } else if (s[i - 1] <= '6') {
                    dp[i] = (dp[i] + dp[i - 2]) % mod;
                }
            }
        }

        return dp[n];
    }
};