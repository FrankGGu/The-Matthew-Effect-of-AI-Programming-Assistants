class Solution:
    def modifyColumns(self, grid: List[List[int]]) -> List[List[int]]:
        rows, cols = len(grid), len(grid[0])
        for j in range(cols):
            col = [grid[i][j] for i in range(rows)]
            col.sort()
            for i in range(rows):
                grid[i][j] = col[i]
        return grid