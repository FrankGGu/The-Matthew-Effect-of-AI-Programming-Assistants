class Solution:
    def minimumWhiteTiles(self, floor: str, numCarpets: int, carpetLen: int) -> int:
        n = len(floor)
        dp = [[0] * (numCarpets + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(numCarpets + 1):
                if j == 0:
                    dp[i][j] = dp[i - 1][j] + int(floor[i - 1])
                else:
                    dp[i][j] = min(dp[i - 1][j] + int(floor[i - 1]), dp[max(0, i - carpetLen)][j - 1])

        return dp[n][numCarpets]