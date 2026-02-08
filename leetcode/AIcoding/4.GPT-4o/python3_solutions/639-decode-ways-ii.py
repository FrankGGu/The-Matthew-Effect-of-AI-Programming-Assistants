class Solution:
    def numDecodings(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)
        if n == 0:
            return 0

        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            if s[i - 1] == '*':
                dp[i] = (dp[i - 1] * 9) % MOD
            elif s[i - 1] != '0':
                dp[i] = dp[i - 1]

            if i > 1:
                if s[i - 2] == '*':
                    if s[i - 1] == '*':
                        dp[i] = (dp[i] + dp[i - 2] * 15) % MOD
                    elif '0' < s[i - 1] <= '6':
                        dp[i] = (dp[i] + dp[i - 2] * 2) % MOD
                    elif s[i - 1] > '6':
                        dp[i] = (dp[i] + dp[i - 2]) % MOD
                else:
                    if s[i - 1] == '*':
                        if '0' < s[i - 2] <= '6':
                            dp[i] = (dp[i] + dp[i - 2] * 2) % MOD
                        elif s[i - 2] > '6':
                            dp[i] = (dp[i] + dp[i - 2]) % MOD
                    elif '10' <= s[i - 2:i] <= '26':
                        dp[i] = (dp[i] + dp[i - 2]) % MOD

        return dp[n]