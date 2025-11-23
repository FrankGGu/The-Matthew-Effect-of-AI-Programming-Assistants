class Solution:
    def minimumTime(self, s: str, time: List[int]) -> int:
        n = len(s)
        dp = [0] * (n + 1)

        for i in range(n):
            dp[i + 1] = dp[i] + time[i]
            if i > 0 and s[i] == s[i - 1]:
                dp[i + 1] = min(dp[i + 1], dp[i - 1] + time[i])

        return dp[n]