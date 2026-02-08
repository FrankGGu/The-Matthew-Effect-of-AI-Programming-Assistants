class Solution:
    def minFlips(self, grid: List[List[int]]) -> int:
        n = len(grid)
        m = len(grid[0])
        total_flips = float('inf')

        def count_flips(start_row, end_row, start_col, end_col):
            flips = 0
            for i in range(start_row, end_row + 1):
                for j in range(start_col, end_col + 1):
                    if grid[i][j] == 1:
                        flips += 1
            return flips

        for i in range(n // 2 + 1):
            for j in range(m // 2 + 1):
                top_left_flips = count_flips(0, i, 0, j)
                top_right_flips = count_flips(0, i, m - j - 1, m - 1)
                bottom_left_flips = count_flips(n - i - 1, n - 1, 0, j)
                bottom_right_flips = count_flips(n - i - 1, n - 1, m - j - 1, m - 1)

                total_flips = min(total_flips, top_left_flips + top_right_flips + bottom_left_flips + bottom_right_flips)

        return total_flips