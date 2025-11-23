class Solution:
    def countSubmatrices(self, grid: list[list[str]]) -> int:
        m = len(grid)
        n = len(grid[0])

        prefix_x = [[0] * (n + 1) for _ in range(m + 1)]
        prefix_y = [[0] * (n + 1) for _ in range(m + 1)]

        count = 0

        for r in range(m):
            for c in range(n):
                current_x = 1 if grid[r][c] == 'X' else 0
                current_y = 1 if grid[r][c] == 'Y' else 0

                prefix_x[r+1][c+1] = current_x + prefix_x[r][c+1] + prefix_x[r+1][c] - prefix_x[r][c]
                prefix_y[r+1][c+1] = current_y + prefix_y[r][c+1] + prefix_y[r+1][c] - prefix_y[r][c]

                if prefix_x[r+1][c+1] == prefix_y[r+1][c+1] and prefix_x[r+1][c+1] > 0:
                    count += 1

        return count