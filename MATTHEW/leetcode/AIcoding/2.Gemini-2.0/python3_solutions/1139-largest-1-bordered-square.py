class Solution:
    def largest1BorderedSquare(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        rows = [[0] * n for _ in range(m)]
        cols = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    rows[i][j] = (rows[i][j - 1] if j > 0 else 0) + 1
                    cols[i][j] = (cols[i - 1][j] if i > 0 else 0) + 1

        max_side = 0
        for i in range(m - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                side = min(rows[i][j], cols[i][j])
                while side > max_side:
                    if rows[i - side + 1][j] >= side and cols[i][j - side + 1] >= side:
                        max_side = side
                        break
                    side -= 1

        return max_side * max_side