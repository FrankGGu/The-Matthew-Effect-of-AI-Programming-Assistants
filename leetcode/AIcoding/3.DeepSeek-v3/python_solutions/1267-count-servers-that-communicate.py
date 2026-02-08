class Solution:
    def countServers(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0]) if rows > 0 else 0
        row_counts = [0] * rows
        col_counts = [0] * cols

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1:
                    row_counts[i] += 1
                    col_counts[j] += 1

        res = 0
        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1 and (row_counts[i] > 1 or col_counts[j] > 1):
                    res += 1
        return res