class Solution:
    def cherryPickup(self, grid: list[list[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        dp = [[[0] * cols for _ in range(cols)] for _ in range(rows)]

        for r in range(rows - 1, -1, -1):
            for c1 in range(cols):
                for c2 in range(cols):
                    current_cherries = grid[r][c1]
                    if c1 != c2:
                        current_cherries += grid[r][c2]

                    if r == rows - 1:
                        dp[r][c1][c2] = current_cherries
                    else:
                        max_next_cherries = 0
                        for move1 in [-1, 0, 1]:
                            for move2 in [-1, 0, 1]:
                                next_c1 = c1 + move1
                                next_c2 = c2 + move2

                                if 0 <= next_c1 < cols and 0 <= next_c2 < cols:
                                    max_next_cherries = max(max_next_cherries, dp[r + 1][next_c1][next_c2])

                        dp[r][c1][c2] = current_cherries + max_next_cherries

        return dp[0][0][cols - 1]