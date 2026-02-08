class Solution:
    def numDecodings(self, s: str) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        dp[0] = 1
        dp[1] = 1 if s[0] != '0' else 0
        mod = 10**9 + 7

        for i in range(2, n + 1):
            if s[i - 1] != '0':
                dp[i] = dp[i - 1] % mod

            if s[i - 2] == '1':
                dp[i] = (dp[i] + dp[i - 2]) % mod
            elif s[i - 2] == '2' and s[i - 1] <= '6':
                dp[i] = (dp[i] + dp[i - 2]) % mod
            elif s[i - 2] == '*':
                if s[i - 1] <= '6':
                    dp[i] = (dp[i] + 2 * dp[i - 2]) % mod
                else:
                    dp[i] = (dp[i] + dp[i - 2]) % mod

            if s[i - 1] == '*':
                if s[i - 2] == '1':
                    dp[i] = (dp[i] + 9 * dp[i - 2]) % mod
                elif s[i - 2] == '2':
                    dp[i] = (dp[i] + 6 * dp[i - 2]) % mod
                elif s[i - 2] == '*':
                    dp[i] = (dp[i] + 15 * dp[i - 2]) % mod

        return dp[n] % mod