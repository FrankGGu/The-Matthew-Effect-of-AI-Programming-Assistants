class Solution:
    def checkValidGrid(self, grid: List[List[int]]) -> bool:
        if grid[0][0] != 0:
            return False
        n = len(grid)
        pos = {}
        for i in range(n):
            for j in range(n):
                pos[grid[i][j]] = (i, j)

        for i in range(n * n - 1):
            x1, y1 = pos[i]
            x2, y2 = pos[i+1]
            if abs(x1 - x2) + abs(y1 - y2) != 3:
                return False
        return True