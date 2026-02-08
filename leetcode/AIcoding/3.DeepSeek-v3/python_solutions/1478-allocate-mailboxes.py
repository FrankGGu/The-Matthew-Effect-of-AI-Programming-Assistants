class Solution:
    def minDistance(self, houses: List[int], k: int) -> int:
        houses.sort()
        n = len(houses)
        cost = [[0] * n for _ in range(n)]

        for i in range(n):
            for j in range(i, n):
                median = houses[(i + j) // 2]
                total = 0
                for m in range(i, j + 1):
                    total += abs(houses[m] - median)
                cost[i][j] = total

        dp = [[float('inf')] * k for _ in range(n)]

        for i in range(n):
            dp[i][0] = cost[0][i]

        for l in range(1, k):
            for i in range(n):
                for j in range(i):
                    if dp[j][l-1] + cost[j+1][i] < dp[i][l]:
                        dp[i][l] = dp[j][l-1] + cost[j+1][i]

        return dp[n-1][k-1]