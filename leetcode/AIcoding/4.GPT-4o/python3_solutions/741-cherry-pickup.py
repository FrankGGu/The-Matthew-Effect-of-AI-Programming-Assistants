class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        n = len(grid)
        dp = [[[-1] * n for _ in range(n)] for _ in range(n)]

        def dfs(x1, y1, x2):
            y2 = x1 + y1 - x2
            if x1 >= n or y1 >= n or x2 >= n or y2 >= n or grid[x1][y1] == -1 or grid[x2][y2] == -1:
                return float('-inf')
            if x1 == n - 1 and y1 == n - 1:
                return grid[x1][y1]
            if dp[x1][y1][x2] != -1:
                return dp[x1][y1][x2]
            cherries = grid[x1][y1]
            if x1 != x2:
                cherries += grid[x2][y2]
            cherries += max(dfs(x1 + 1, y1, x2), 
                            dfs(x1, y1 + 1, x2), 
                            dfs(x1 + 1, y1, x2 + 1), 
                            dfs(x1, y1 + 1, x2 + 1))
            dp[x1][y1][x2] = cherries
            return cherries

        return max(0, dfs(0, 0, 0))