class Solution:
    def maxSum(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        max_hourglass_sum = 0

        for r in range(m - 2):
            for c in range(n - 2):
                current_hourglass_sum = (
                    grid[r][c] + grid[r][c+1] + grid[r][c+2] +
                    grid[r+1][c+1] +
                    grid[r+2][c] + grid[r+2][c+1] + grid[r+2][c+2]
                )
                max_hourglass_sum = max(max_hourglass_sum, current_hourglass_sum)

        return max_hourglass_sum