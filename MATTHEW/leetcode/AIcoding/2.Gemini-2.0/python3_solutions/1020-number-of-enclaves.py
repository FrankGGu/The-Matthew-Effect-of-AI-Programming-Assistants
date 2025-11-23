class Solution:
    def numEnclaves(self, grid: list[list[int]]) -> int:
        rows, cols = len(grid), len(grid[0])

        def dfs(row, col):
            if row < 0 or row >= rows or col < 0 or col >= cols or grid[row][col] == 0:
                return

            grid[row][col] = 0
            dfs(row + 1, col)
            dfs(row - 1, col)
            dfs(row, col + 1)
            dfs(row, col - 1)

        for i in range(rows):
            dfs(i, 0)
            dfs(i, cols - 1)

        for j in range(cols):
            dfs(0, j)
            dfs(rows - 1, j)

        count = 0
        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1:
                    count += 1

        return count