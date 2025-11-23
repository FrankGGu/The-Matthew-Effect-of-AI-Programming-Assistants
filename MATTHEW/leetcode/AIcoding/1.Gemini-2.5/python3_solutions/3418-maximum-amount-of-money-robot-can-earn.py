import math

class Solution:
    def maximumRobots(self, grid: list[list[int]]) -> int:
        n = len(grid[0])

        # prefix_row0[k] stores the sum of grid[0][0] to grid[0][k]
        prefix_row0 = [0] * n
        prefix_row0[0] = grid[0][0]
        for k in range(1, n):
            prefix_row0[k] = prefix_row0[k-1] + grid[0][k]

        # suffix_row1[k] stores the sum of grid[1][k] to grid[1][n-1]
        suffix_row1 = [0] * n
        suffix_row1[n-1] = grid[1][n-1]
        for k in range(n - 2, -1, -1):
            suffix_row1[k] = suffix_row1[k+1] + grid[1][k]

        max_total_money = 0

        # Iterate through all possible turn points (column i)
        # A robot's path is (0,0) -> ... -> (0,i) -> (1,i) -> ... -> (1,n-1)
        for i in range(n):
            # Money collected from the top row segment: grid[0][0] to grid[0][i]
            money_from_row0 = prefix_row0[i]

            # Money collected from the bottom row segment: grid[1][i] to grid[1][n-1]
            money_from_row1 = suffix_row1[i]

            # Total money for this path
            total_money = money_from_row0 + money_from_row1

            # Update the maximum total money found so far
            max_total_money = max(max_total_money, total_money)

        return max_total_money