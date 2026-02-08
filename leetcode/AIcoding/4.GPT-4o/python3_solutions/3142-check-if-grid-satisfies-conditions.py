class Solution:
    def checkGrid(self, grid: List[List[int]]) -> bool:
        n, m = len(grid), len(grid[0])

        for i in range(n):
            if sum(grid[i]) != n:
                return False

        for j in range(m):
            if sum(grid[i][j] for i in range(n)) != m:
                return False

        return True