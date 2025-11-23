class Solution:
    def checkValidGrid(self, grid: List[List[int]]) -> bool:
        if grid[0][0] != 0:
            return False

        n = len(grid)
        pos = {}
        for r in range(n):
            for c in range(n):
                pos[grid[r][c]] = (r, c)

        for i in range(n * n - 1):
            r1, c1 = pos[i]
            r2, c2 = pos[i + 1]
            if abs(r1 - r2) * abs(c1 - c2) != 2:
                return False

        return True