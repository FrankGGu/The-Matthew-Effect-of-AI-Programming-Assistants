class Solution:
    def minDistance(self, houses: List[int], k: int) -> int:
        houses.sort()
        n = len(houses)
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        def cost(l, r):
            mid = (l + r) // 2
            return sum(abs(houses[i] - houses[mid]) for i in range(l, r + 1))

        for i in range(1, n + 1):
            for j in range(1, min(i, k) + 1):
                for p in range(i):
                    dp[i][j] = min(dp[i][j], dp[p][j - 1] + cost(p, i - 1))

        return dp[n][k]