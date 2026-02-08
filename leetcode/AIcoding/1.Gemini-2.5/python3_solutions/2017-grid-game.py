import math

class Solution:
    def gridGame(self, grid: list[list[int]]) -> int:
        n = len(grid[0])

        prefix_sum_row0 = [0] * n
        prefix_sum_row1 = [0] * n

        prefix_sum_row0[0] = grid[0][0]
        prefix_sum_row1[0] = grid[1][0]

        for k in range(1, n):
            prefix_sum_row0[k] = prefix_sum_row0[k-1] + grid[0][k]
            prefix_sum_row1[k] = prefix_sum_row1[k-1] + grid[1][k]

        min_max_score = math.inf

        for i in range(n):
            current_bottom_left_sum = 0
            if i > 0:
                current_bottom_left_sum = prefix_sum_row1[i-1]

            current_top_right_sum = 0
            if i < n - 1:
                current_top_right_sum = prefix_sum_row0[n-1] - prefix_sum_row0[i]

            robot2_score = max(current_bottom_left_sum, current_top_right_sum)

            min_max_score = min(min_max_score, robot2_score)

        return min_max_score