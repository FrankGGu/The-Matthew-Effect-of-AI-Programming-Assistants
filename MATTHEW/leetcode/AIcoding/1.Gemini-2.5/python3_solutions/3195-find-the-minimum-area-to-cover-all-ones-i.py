class Solution:
    def minimumArea(self, grid: list[list[int]]) -> int:
        min_r = float('inf')
        max_r = float('-inf')
        min_c = float('inf')
        max_c = float('-inf')

        rows = len(grid)
        cols = len(grid[0])

        found_one = False
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    found_one = True
                    min_r = min(min_r, r)
                    max_r = max(max_r, r)
                    min_c = min(min_c, c)
                    max_c = max(max_c, c)

        if not found_one:
            return 0

        return (max_r - min_r + 1) * (max_c - min_c + 1)