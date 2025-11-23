class Solution:
    def stoneGameII(self, piles: List[int]) -> int:
        n = len(piles)
        dp = [[0] * (n + 1) for _ in range(n)]

        for i in range(n - 1, -1, -1):
            dp[i][n] = piles[i]
            for j in range(n - 1, 0, -1):
                dp[i][j] = max(dp[i][j + 1], piles[i] + dp[i + 1][j + 1])

        return dp[0][1]