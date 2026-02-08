class Solution:
    def countPaths(self, grid: List[List[int]]) -> int:
        MOD = 10**9 + 7
        m, n = len(grid), len(grid[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        dp = [[1] * n for _ in range(m)]

        cells = []
        for i in range(m):
            for j in range(n):
                cells.append((grid[i][j], i, j))
        cells.sort()

        for val, i, j in cells:
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] > val:
                    dp[ni][nj] = (dp[ni][nj] + dp[i][j]) % MOD

        total = 0
        for row in dp:
            total = (total + sum(row)) % MOD
        return total