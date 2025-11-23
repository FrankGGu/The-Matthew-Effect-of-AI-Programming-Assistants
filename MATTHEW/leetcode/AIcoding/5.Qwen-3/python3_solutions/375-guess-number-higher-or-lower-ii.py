class Solution:
    def getMoneyAmount(self, n: int) -> int:
        dp = [[0] * (n + 1) for _ in range(n + 1)]
        for i in range(n - 1, 0, -1):
            for j in range(i + 1, n + 1):
                min_cost = float('inf')
                for k in range(i, j):
                    cost = k + max(dp[i][k - 1], dp[k + 1][j])
                    min_cost = min(min_cost, cost)
                dp[i][j] = min_cost
        return dp[1][n]