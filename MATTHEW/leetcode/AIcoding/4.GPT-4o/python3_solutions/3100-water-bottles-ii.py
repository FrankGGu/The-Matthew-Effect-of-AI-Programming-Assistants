class Solution:
    def waterBottle(self, n: int, r: int) -> int:
        dp = [0] * (n + 1)
        for i in range(1, n + 1):
            for j in range(1, r + 1):
                if i - j >= 0:
                    dp[i] = max(dp[i], dp[i - j] + j)
        return dp[n]