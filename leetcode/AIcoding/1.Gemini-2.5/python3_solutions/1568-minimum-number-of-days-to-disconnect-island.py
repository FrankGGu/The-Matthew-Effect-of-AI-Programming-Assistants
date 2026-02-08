from typing import List

class Solution:
    def minDays(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        def count_islands(current_grid):
            R, C = len(current_grid), len(current_grid[0])
            visited = set()
            num_islands = 0

            def dfs(r, c):
                if not (0 <= r < R and 0 <= c < C and current_grid[r][c] == 1 and (r, c) not in visited):
                    return
                visited.add((r, c))
                dfs(r + 1, c)
                dfs(r - 1, c)
                dfs(r, c + 1)
                dfs(r, c - 1)

            for r_idx in range(R):
                for c_idx in range(C):
                    if current_grid[r_idx][c_idx] == 1 and (r_idx, c_idx) not in visited:
                        num_islands += 1
                        dfs(r_idx, c_idx)
            return num_islands

        if count_islands(grid) != 1:
            return 0

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    grid[r][c] = 0
                    if count_islands(grid) != 1:
                        grid[r][c] = 1
                        return 1
                    grid[r][c] = 1

        return 2