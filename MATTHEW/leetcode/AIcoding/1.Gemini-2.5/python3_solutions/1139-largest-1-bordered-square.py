from typing import List

class Solution:
    def largest1BorderedSquare(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        left = [[0] * cols for _ in range(rows)]
        up = [[0] * cols for _ in range(rows)]

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    left[r][c] = 1 + (left[r][c-1] if c > 0 else 0)
                    up[r][c] = 1 + (up[r-1][c] if r > 0 else 0)

        max_k = 0

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 0:
                    continue

                for s in range(min(left[r][c], up[r][c]), max_k, -1):
                    if left[r - s + 1][c] >= s and up[r][c - s + 1] >= s:
                        max_k = s
                        break

        return max_k * max_k