class Solution:
    def maxIncreaseKeepingSkyline(self, grid: List[List[int]]) -> int:
        if not grid or not grid[0]:
            return 0
        rows = len(grid)
        cols = len(grid[0])
        row_max = [max(grid[i]) for i in range(rows)]
        col_max = [max(grid[i][j] for i in range(rows)) for j in range(cols)]
        result = 0
        for i in range(rows):
            for j in range(cols):
                result += min(row_max[i], col_max[j]) - grid[i][j]
        return result