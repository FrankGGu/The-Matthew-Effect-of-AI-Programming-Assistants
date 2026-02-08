class Solution:
    def minSkips(self, dist: List[int], speed: int, hoursBefore: int) -> int:
        n = len(dist)
        eps = 1e-9
        dp = [[float('inf')] * (n + 1) for _ in range(n + 1)]
        dp[0][0] = 0.0

        for i in range(1, n + 1):
            d = dist[i - 1]
            for j in range(0, i + 1):
                if j < i:
                    dp[i][j] = min(dp[i][j], math.ceil(dp[i - 1][j] + d / speed - eps))
                if j > 0:
                    dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + d / speed)

        for j in range(n + 1):
            if dp[n][j] <= hoursBefore + eps:
                return j
        return -1