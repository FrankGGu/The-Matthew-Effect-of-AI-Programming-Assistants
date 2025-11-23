class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        for i in range(n):
            if s[i] == '1':
                dp[i + 1] = dp[i]
            else:
                dp[i + 1] = min(dp[i] + 1, dp[i])
        return dp[n]