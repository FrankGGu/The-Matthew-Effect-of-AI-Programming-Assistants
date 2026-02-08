class Solution:
    def waysToEarnPoints(self, points: int, a: int, b: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (points + 1)
        dp[0] = 1

        for i in range(1, points + 1):
            if i >= a:
                dp[i] = (dp[i] + dp[i - a]) % MOD
            if i >= b:
                dp[i] = (dp[i] + dp[i - b]) % MOD

        return dp[points]