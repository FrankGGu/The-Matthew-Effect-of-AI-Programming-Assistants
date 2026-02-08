class Solution:
    def minimumFlips(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])
        total_flips = 0

        for r in range((m + 1) // 2):
            for c in range((n + 1) // 2):
                values = []
                values.append(grid[r][c])

                sym_r = m - 1 - r
                sym_c = n - 1 - c

                if sym_r != r:
                    values.append(grid[sym_r][c])
                if sym_c != c:
                    values.append(grid[r][sym_c])
                if sym_r != r and sym_c != c:
                    values.append(grid[sym_r][sym_c])

                count_0 = values.count(0)
                count_1 = values.count(1)
                total_flips += min(count_0, count_1)

        return total_flips