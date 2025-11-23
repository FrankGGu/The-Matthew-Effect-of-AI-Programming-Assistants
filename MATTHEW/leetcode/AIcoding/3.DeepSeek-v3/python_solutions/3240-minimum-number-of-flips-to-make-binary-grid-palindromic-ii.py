class Solution:
    def minFlips(self, grid: List[List[int]]) -> int:
        n = len(grid)
        res = 0
        for i in range(n // 2):
            for j in range(n // 2):
                cnt = grid[i][j] + grid[i][n - 1 - j] + grid[n - 1 - i][j] + grid[n - 1 - i][n - 1 - j]
                res += min(cnt, 4 - cnt)
        if n % 2 == 1:
            mid = n // 2
            for j in range(n // 2):
                cnt = grid[mid][j] + grid[mid][n - 1 - j]
                res += min(cnt, 2 - cnt)
        return res