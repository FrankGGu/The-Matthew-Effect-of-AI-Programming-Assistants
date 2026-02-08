class Solution:
    def numEnclaves(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])

        def dfs(r, c):
            if r < 0 or r >= rows or c < 0 or c >= cols or grid[r][c] == 0:
                return
            grid[r][c] = 0
            for dr, dc in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                dfs(r + dr, c + dc)

        for r in range(rows):
            if grid[r][0] == 1:
                dfs(r, 0)
            if grid[r][cols - 1] == 1:
                dfs(r, cols - 1)

        for c in range(cols):
            if grid[0][c] == 1:
                dfs(0, c)
            if grid[rows - 1][c] == 1:
                dfs(rows - 1, c)

        return sum(grid[r][c] for r in range(rows) for c in range(cols))