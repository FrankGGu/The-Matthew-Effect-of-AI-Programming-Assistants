class Solution:
    def numDecodings(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)
        if n == 0:
            return 0
        dp = [0] * (n + 1)
        dp[0] = 1
        dp[1] = 0 if s[0] == '0' else 1
        for i in range(2, n + 1):
            one_digit = int(s[i-1])
            two_digit = int(s[i-2:i])
            if one_digit >= 1 and one_digit <= 9:
                dp[i] += dp[i-1]
            if two_digit >= 10 and two_digit <= 26:
                dp[i] += dp[i-2]
            dp[i] %= MOD
        return dp[n]