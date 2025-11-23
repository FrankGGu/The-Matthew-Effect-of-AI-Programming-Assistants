class Solution:
    def equalPairs(self, grid: List[List[int]]) -> int:
        row_counts = {}
        n = len(grid)
        for row in grid:
            row_tuple = tuple(row)
            row_counts[row_tuple] = row_counts.get(row_tuple, 0) + 1

        count = 0
        for j in range(n):
            column = []
            for i in range(n):
                column.append(grid[i][j])
            column_tuple = tuple(column)
            count += row_counts.get(column_tuple, 0)

        return count