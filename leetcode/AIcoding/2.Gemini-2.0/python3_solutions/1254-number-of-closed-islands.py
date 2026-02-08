class Solution:
    def closedIsland(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])

        def dfs(row, col):
            if row < 0 or row >= rows or col < 0 or col >= cols or grid[row][col] == 1:
                return
            grid[row][col] = 1
            dfs(row + 1, col)
            dfs(row - 1, col)
            dfs(row, col + 1)
            dfs(row, col - 1)

        for i in range(rows):
            for j in range(cols):
                if (i == 0 or i == rows - 1 or j == 0 or j == cols - 1) and grid[i][j] == 0:
                    dfs(i, j)

        count = 0
        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 0:
                    count += 1
                    dfs(i, j)

        return count