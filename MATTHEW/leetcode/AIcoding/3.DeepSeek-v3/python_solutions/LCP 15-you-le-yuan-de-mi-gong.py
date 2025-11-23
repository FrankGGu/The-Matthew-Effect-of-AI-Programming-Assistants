class Solution:
    def countPaths(self, grid: List[List[int]]) -> int:
        mod = 10**9 + 7
        m, n = len(grid), len(grid[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        dp = [[1] * n for _ in range(m)]
        cells = [(i, j) for i in range(m) for j in range(n)]
        cells.sort(key=lambda x: grid[x[0]][x[1]])

        for i, j in cells:
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] > grid[i][j]:
                    dp[ni][nj] = (dp[ni][nj] + dp[i][j]) % mod

        return sum(sum(row) % mod for row in dp) % mod