class Solution:
    def orderOfLargestPlusSign(self, n: int, mines: list[list[int]]) -> int:
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
                    left[r][c] = 1 + (left[r][c-1] if c > 0 else 0)
                    up[r][c] = 1 + (up[r-1][c] if r > 0 else 0)

        for r in range(n - 1, -1, -1):
            for c in range(n - 1, -1, -1):
                if grid[r][c] == 1:
                    right[r][c] = 1 + (right[r][c+1] if c < n - 1 else 0)
                    down[r][c] = 1 + (down[r+1][c] if r < n - 1 else 0)

        max_order = 0
        for r in range(n):
            for c in range(n):
                current_order = min(left[r][c], right[r][c], up[r][c], down[r][c])
                max_order = max(max_order, current_order)

        return max_order