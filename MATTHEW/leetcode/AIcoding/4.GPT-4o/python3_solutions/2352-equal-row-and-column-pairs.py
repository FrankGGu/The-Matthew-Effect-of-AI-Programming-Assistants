class Solution:
    def equalPairs(self, grid: List[List[int]]) -> int:
        from collections import Counter

        row_count = Counter(tuple(row) for row in grid)
        col_count = Counter(tuple(grid[i][j] for i in range(len(grid))) for j in range(len(grid[0])))

        return sum(row_count[row] * col_count[row] for row in row_count)