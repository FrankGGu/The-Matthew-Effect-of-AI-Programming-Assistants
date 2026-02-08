class Solution:
    def findColumnWidth(self, grid: List[List[int]]) -> List[int]:
        m = len(grid)
        n = len(grid[0])
        widths = [0] * n
        for j in range(n):
            max_width = 0
            for i in range(m):
                width = len(str(grid[i][j]))
                max_width = max(max_width, width)
            widths[j] = max_width
        return widths