class Solution:
    def matrixScore(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        score = 0

        score += m * (1 << (n - 1))

        for j in range(1, n):
            ones_in_col_j = 0
            for i in range(m):
                effective_val = grid[i][j] if grid[i][0] == 1 else (1 - grid[i][j])

                if effective_val == 1:
                    ones_in_col_j += 1

            num_ones_to_add = max(ones_in_col_j, m - ones_in_col_j)

            score += num_ones_to_add * (1 << (n - 1 - j))

        return score