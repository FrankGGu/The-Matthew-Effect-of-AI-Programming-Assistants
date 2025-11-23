class Solution:
    def minPathCost(self, grid: List[List[int]], moveCost: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        dp[0] = grid[0].copy()

        for i in range(1, m):
            for j in range(n):
                min_cost = float('inf')
                for k in range(n):
                    cost = dp[i-1][k] + moveCost[grid[i-1][k]][j] + grid[i][j]
                    if cost < min_cost:
                        min_cost = cost
                dp[i][j] = min_cost

        return min(dp[-1])