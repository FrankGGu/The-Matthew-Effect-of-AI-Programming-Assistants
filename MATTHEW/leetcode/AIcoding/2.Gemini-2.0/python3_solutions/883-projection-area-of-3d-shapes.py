class Solution:
    def projectionArea(self, grid: List[List[int]]) -> int:
        n = len(grid)
        area = 0
        for i in range(n):
            max_row = 0
            max_col = 0
            for j in range(n):
                if grid[i][j] > 0:
                    area += 1
                max_row = max(max_row, grid[i][j])
                max_col = max(max_col, grid[j][i])
            area += max_row
            area += max_col
        return area - n * n