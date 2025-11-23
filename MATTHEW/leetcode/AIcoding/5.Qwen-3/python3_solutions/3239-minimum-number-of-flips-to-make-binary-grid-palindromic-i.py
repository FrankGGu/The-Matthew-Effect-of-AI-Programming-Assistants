class Solution:
    def minFlips(self, grid: List[List[int]]) -> int:
        n = len(grid)
        m = len(grid[0])
        res = 0
        for i in range(n):
            for j in range(m // 2):
                if grid[i][j] != grid[i][m - 1 - j]:
                    res += 1
        for j in range(m):
            for i in range(n // 2):
                if grid[i][j] != grid[n - 1 - i][j]:
                    res += 1
        return res