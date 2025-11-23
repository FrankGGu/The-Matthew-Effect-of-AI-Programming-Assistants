class Solution:
    def maxIncreaseKeepingSkyline(self, grid: List[List[int]]) -> int:
        row_max = [max(row) for row in grid]
        col_max = [max(col) for col in zip(*grid)]

        total = 0
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                total += min(row_max[i], col_max[j]) - grid[i][j]

        return total