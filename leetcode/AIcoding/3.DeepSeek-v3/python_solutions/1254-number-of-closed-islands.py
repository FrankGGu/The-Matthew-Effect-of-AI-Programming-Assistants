class Solution:
    def closedIsland(self, grid: List[List[int]]) -> int:
        if not grid:
            return 0

        rows, cols = len(grid), len(grid[0])
        count = 0

        def dfs(i, j):
            if i < 0 or i >= rows or j < 0 or j >= cols:
                return False
            if grid[i][j] == 1:
                return True
            grid[i][j] = 1
            up = dfs(i - 1, j)
            down = dfs(i + 1, j)
            left = dfs(i, j - 1)
            right = dfs(i, j + 1)
            return up and down and left and right

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 0:
                    if dfs(i, j):
                        count += 1
        return count