from typing import List

class Solution:
    def numEnclaves(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        def dfs(r, c):
            if r < 0 or r >= rows or c < 0 or c >= cols or grid[r][c] == 0:
                return

            grid[r][c] = 0 

            dfs(r + 1, c)
            dfs(r - 1, c)
            dfs(r, c + 1)
            dfs(r, c - 1)

        for c in range(cols):
            if grid[0][c] == 1:
                dfs(0, c)
            if grid[rows - 1][c] == 1:
                dfs(rows - 1, c)

        for r in range(rows):
            if grid[r][0] == 1:
                dfs(r, 0)
            if grid[r][cols - 1] == 1:
                dfs(r, cols - 1)

        enclaves_count = 0
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    enclaves_count += 1

        return enclaves_count