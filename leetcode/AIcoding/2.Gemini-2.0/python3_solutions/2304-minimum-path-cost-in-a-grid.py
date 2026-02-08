class Solution:
    def minPathCost(self, grid: List[List[int]], moveCost: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])
        dp = [float('inf')] * n
        dp[0:n] = grid[0][:]

        for i in range(m - 1):
            new_dp = [float('inf')] * n
            for j in range(n):
                for k in range(n):
                    new_dp[k] = min(new_dp[k], dp[j] + moveCost[grid[i][j]][k] + grid[i+1][k])
            dp = new_dp
        return min(dp)