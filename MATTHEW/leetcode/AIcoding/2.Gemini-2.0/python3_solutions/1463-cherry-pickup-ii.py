class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        dp = {}

        def solve(row, col1, col2):
            if row == rows:
                return 0

            if (row, col1, col2) in dp:
                return dp[(row, col1, col2)]

            cherries = 0
            if col1 == col2:
                cherries += grid[row][col1]
            else:
                cherries += grid[row][col1] + grid[row][col2]

            max_cherries = 0
            for next_col1 in range(max(0, col1 - 1), min(cols, col1 + 2)):
                for next_col2 in range(max(0, col2 - 1), min(cols, col2 + 2)):
                    max_cherries = max(max_cherries, solve(row + 1, next_col1, next_col2))

            cherries += max_cherries
            dp[(row, col1, col2)] = cherries
            return cherries

        return solve(0, 0, cols - 1)