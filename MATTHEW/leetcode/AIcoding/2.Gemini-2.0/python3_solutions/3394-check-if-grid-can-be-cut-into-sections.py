class Solution:
    def check_if_grid_can_be_cut(self, grid: List[List[int]]) -> bool:
        m, n = len(grid), len(grid[0])
        total_sum = sum(sum(row) for row in grid)

        def get_sum(row1, col1, row2, col2):
            s = 0
            for i in range(row1, row2 + 1):
                for j in range(col1, col2 + 1):
                    s += grid[i][j]
            return s

        def solve():
            for i in range(1, m):
                top_sum = get_sum(0, 0, i - 1, n - 1)
                bottom_sum = get_sum(i, 0, m - 1, n - 1)
                if top_sum != 0 and bottom_sum != 0 and top_sum != total_sum and bottom_sum != total_sum:
                    return True
            for j in range(1, n):
                left_sum = get_sum(0, 0, m - 1, j - 1)
                right_sum = get_sum(0, j, m - 1, n - 1)
                if left_sum != 0 and right_sum != 0 and left_sum != total_sum and right_sum != total_sum:
                    return True
            return False

        return solve()