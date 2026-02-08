class Solution:
    def maxMoves(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[False] * n for _ in range(m)]
        for i in range(m):
            dp[i][0] = True
        ans = 0
        for j in range(n - 1):
            for i in range(m):
                if dp[i][j]:
                    if i > 0 and grid[i - 1][j + 1] > grid[i][j]:
                        dp[i - 1][j + 1] = True
                    if grid[i][j + 1] > grid[i][j]:
                        dp[i][j + 1] = True
                    if i < m - 1 and grid[i + 1][j + 1] > grid[i][j]:
                        dp[i + 1][j + 1] = True
            if any(dp[i][j+1] for i in range(m)):
                ans = j+1
            else:
                break
        return ans