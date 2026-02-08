class Solution:
    def knightProbability(self, n: int, k: int, row: int, column: int) -> float:
        moves = [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1)]
        dp = [[[0.0 for _ in range(n)] for __ in range(n)] for ___ in range(k + 1)]
        dp[0][row][column] = 1.0

        for step in range(1, k + 1):
            for i in range(n):
                for j in range(n):
                    for di, dj in moves:
                        ni, nj = i + di, j + dj
                        if 0 <= ni < n and 0 <= nj < n:
                            dp[step][i][j] += dp[step - 1][ni][nj] / 8.0

        total = 0.0
        for i in range(n):
            for j in range(n):
                total += dp[k][i][j]

        return total