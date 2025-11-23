class Solution:
    def minPathCost(self, grid: list[list[int]], moveCost: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        # dp[r][c] will store the minimum cost to reach cell (r, c)
        dp = [[float('inf')] * n for _ in range(m)]

        # Initialize the first row of dp table
        # The cost to reach any cell in the first row is just its value
        for c in range(n):
            dp[0][c] = grid[0][c]

        # Iterate through the grid starting from the second row
        for r in range(1, m):
            for c_curr in range(n):
                # To reach (r, c_curr), we must come from some cell (r-1, c_prev)
                # Iterate over all possible previous columns
                min_cost_from_prev_row = float('inf')
                for c_prev in range(n):
                    # Value of the cell in the previous row from which we are moving
                    prev_cell_value = grid[r-1][c_prev]

                    # Cost to move from prev_cell_value to current column c_curr
                    cost_to_move = moveCost[prev_cell_value][c_curr]

                    # Total cost to reach (r-1, c_prev) and then move to column c_curr
                    total_cost_through_prev_cell = dp[r-1][c_prev] + cost_to_move

                    min_cost_from_prev_row = min(min_cost_from_prev_row, total_cost_through_prev_cell)

                # The minimum cost to reach (r, c_curr) is the minimum cost from any
                # previous cell plus the value of the current cell (r, c_curr)
                dp[r][c_curr] = min_cost_from_prev_row + grid[r][c_curr]

        # The minimum path cost is the minimum value in the last row of the dp table
        return min(dp[m-1])