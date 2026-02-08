class Solution {
public:
    int numDecodings(string s) {
        const int MOD = 1e9 + 7;
        int n = s.size();
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= n; ++i) {
            char c = s[i - 1];
            if (c == '*') {
                dp[i] = (dp[i] + 9 * dp[i - 1]) % MOD;
            } else if (c != '0') {
                dp[i] = (dp[i] + dp[i - 1]) % MOD;
            }
            if (i >= 2) {
                char prev = s[i - 2];
                if (prev == '*') {
                    if (c == '*') {
                        dp[i] = (dp[i] + 15 * dp[i - 2]) % MOD;
                    } else if (c <= '6') {
                        dp[i] = (dp[i] + 2 * dp[i - 2]) % MOD;
                    } else {
                        dp[i] = (dp[i] + dp[i - 2]) % MOD;
                    }
                } else if (prev == '1') {
                    if (c == '*') {
                        dp[i] = (dp[i] + 9 * dp[i - 2]) % MOD;
                    } else {
                        dp[i] = (dp[i] + dp[i - 2]) % MOD;
                    }
                } else if (prev == '2') {
                    if (c == '*') {
                        dp[i] = (dp[i] + 6 * dp[i - 2]) % MOD;
                    } else if (c <= '6') {
                        dp[i] = (dp[i] + dp[i - 2]) % MOD;
                    }
                }
            }
        }
        return dp[n];
    }
};