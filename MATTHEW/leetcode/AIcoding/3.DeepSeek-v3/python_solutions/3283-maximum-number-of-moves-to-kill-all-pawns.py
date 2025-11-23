class Solution:
    def maxMoves(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        max_moves = 0

        for j in range(n - 2, -1, -1):
            for i in range(m):
                current_val = grid[i][j]
                max_next = 0
                for di, dj in [(-1, 1), (0, 1), (1, 1)]:
                    ni, nj = i + di, j + dj
                    if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] > current_val:
                        max_next = max(max_next, dp[ni][nj] + 1)
                dp[i][j] = max_next
                if j == 0:
                    max_moves = max(max_moves, dp[i][j])

        return max_moves