class Solution:
    def countServers(self, grid: List[List[int]]) -> int:
        row_count = len(grid)
        col_count = len(grid[0])

        row_serve = [0] * row_count
        col_serve = [0] * col_count

        for r in range(row_count):
            for c in range(col_count):
                if grid[r][c] == 1:
                    row_serve[r] += 1
                    col_serve[c] += 1

        count = 0
        for r in range(row_count):
            for c in range(col_count):
                if grid[r][c] == 1 and (row_serve[r] > 1 or col_serve[c] > 1):
                    count += 1

        return count