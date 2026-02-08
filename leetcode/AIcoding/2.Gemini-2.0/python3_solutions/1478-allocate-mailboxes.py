class Solution:
    def minDistance(self, houses: list[int], k: int) -> int:
        houses.sort()
        n = len(houses)

        cost = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(i + 1, n):
                mid = (i + j) // 2
                for l in range(i, j + 1):
                    cost[i][j] += abs(houses[l] - houses[mid])

        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(1, min(i, k) + 1):
                for l in range(1, i + 1):
                    dp[i][j] = min(dp[i][j], dp[l - 1][j - 1] + cost[l - 1][i - 1])

        return dp[n][k]