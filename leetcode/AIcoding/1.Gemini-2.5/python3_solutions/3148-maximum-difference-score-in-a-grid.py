class Solution:
    def maxDifferenceScore(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        min_prefix_grid = [[0] * n for _ in range(m)]

        max_score = -float('inf')

        for r in range(m):
            for c in range(n):
                current_val = grid[r][c]

                min_val_from_top_left_region = float('inf')

                if r > 0:
                    min_val_from_top_left_region = min(min_val_from_top_left_region, min_prefix_grid[r-1][c])

                if c > 0:
                    min_val_from_top_left_region = min(min_val_from_top_left_region, min_prefix_grid[r][c-1])

                if min_val_from_top_left_region != float('inf'):
                    max_score = max(max_score, current_val - min_val_from_top_left_region)

                min_prefix_grid[r][c] = current_val
                if r > 0:
                    min_prefix_grid[r][c] = min(min_prefix_grid[r][c], min_prefix_grid[r-1][c])
                if c > 0:
                    min_prefix_grid[r][c] = min(min_prefix_grid[r][c], min_prefix_grid[r][c-1])

        return max_score