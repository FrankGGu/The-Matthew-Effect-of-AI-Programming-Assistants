class Solution:
    def checkValidGrid(self, grid: List[List[int]]) -> bool:
        if grid[0][0] != 0:
            return False
        n = len(grid)
        positions = [None] * (n * n)
        for i in range(n):
            for j in range(n):
                positions[grid[i][j]] = (i, j)
        for step in range(1, len(positions)):
            prev_x, prev_y = positions[step - 1]
            curr_x, curr_y = positions[step]
            dx = abs(curr_x - prev_x)
            dy = abs(curr_y - prev_y)
            if not ((dx == 1 and dy == 2) or (dx == 2 and dy == 1)):
                return False
        return True