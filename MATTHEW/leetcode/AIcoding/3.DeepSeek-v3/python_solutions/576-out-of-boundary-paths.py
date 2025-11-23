class Solution:
    def findPaths(self, m: int, n: int, maxMove: int, startRow: int, startColumn: int) -> int:
        MOD = 10**9 + 7
        dp = [[[0] * n for _ in range(m)] for _ in range(maxMove + 1)]
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        for move in range(1, maxMove + 1):
            for i in range(m):
                for j in range(n):
                    for di, dj in directions:
                        ni, nj = i + di, j + dj
                        if ni < 0 or ni >= m or nj < 0 or nj >= n:
                            dp[move][i][j] += 1
                        else:
                            dp[move][i][j] += dp[move - 1][ni][nj]
                        dp[move][i][j] %= MOD

        return dp[maxMove][startRow][startColumn]