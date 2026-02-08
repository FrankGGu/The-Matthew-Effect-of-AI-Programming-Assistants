class Solution:
    def minimumTime(self, s: str) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        for i in range(1, n + 1):
            dp[i] = dp[i - 1] + 1
            if s[i - 1] == '1':
                dp[i] = min(dp[i], dp[i - 1] + 2)
                dp[i] = min(dp[i], i)
        return dp[n]