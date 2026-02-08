from typing import List

class Solution:
    def findMaxFish(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])
        max_fish = 0

        def dfs(r, c):
            if not (0 <= r < rows and 0 <= c < cols) or grid[r][c] == 0:
                return 0

            current_fish = grid[r][c]
            grid[r][c] = 0  # Mark as visited by setting to 0

            current_fish += dfs(r + 1, c)
            current_fish += dfs(r - 1, c)
            current_fish += dfs(r, c + 1)
            current_fish += dfs(r, c - 1)

            return current_fish

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] > 0:  # If there's fish and not yet visited
                    max_fish = max(max_fish, dfs(r, c))

        return max_fish