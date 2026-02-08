class Solution:
    def knightProbability(self, n: int, k: int, row: int, column: int) -> float:

        dp = [[0.0] * n for _ in range(n)]
        dp[row][column] = 1.0

        dr = [-2, -2, -1, -1, 1, 1, 2, 2]
        dc = [-1, 1, -2, 2, -2, 2, -1, 1]

        for _ in range(k):
            next_dp = [[0.0] * n for _ in range(n)]
            for r in range(n):
                for c in range(n):
                    if dp[r][c] > 0:
                        for i in range(8):
                            next_r, next_c = r + dr[i], c + dc[i]
                            if 0 <= next_r < n and 0 <= next_c < n:
                                next_dp[next_r][next_c] += dp[r][c] / 8.0
            dp = next_dp

        total_probability = 0.0
        for r in range(n):
            for c in range(n):
                total_probability += dp[r][c]

        return total_probability