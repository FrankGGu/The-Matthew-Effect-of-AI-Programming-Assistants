class Solution:
    def orderOfLargestPlusSign(self, n: int, mines: List[List[int]]) -> int:
        grid = [[1] * n for _ in range(n)]
        for r, c in mines:
            grid[r][c] = 0

        left = [[0] * n for _ in range(n)]
        right = [[0] * n for _ in range(n)]
        up = [[0] * n for _ in range(n)]
        down = [[0] * n for _ in range(n)]

        for r in range(n):
            for c in range(n):
                if grid[r][c] == 1:
                    left[r][c] = left[r][c - 1] + 1 if c > 0 else 1
                if grid[r][n - 1 - c] == 1:
                    right[r][n - 1 - c] = right[r][n - c] + 1 if c > 0 else 1
                if grid[c][r] == 1:
                    up[c][r] = up[c - 1][r] + 1 if c > 0 else 1
                if grid[n - 1 - c][r] == 1:
                    down[n - 1 - c][r] = down[n - c][r] + 1 if c > 0 else 1

        max_order = 0
        for r in range(n):
            for c in range(n):
                if grid[r][c] == 1:
                    max_order = max(max_order, min(left[r][c], right[r][c], up[r][c], down[r][c]))

        return max_order