class Solution:
    def findRotateSteps(self, ring: str, key: str) -> int:
        n, m = len(ring), len(key)
        dp = [[float('inf')] * n for _ in range(m)]

        for i in range(n):
            dp[0][i] = min(i, n - i) + 1  # Steps to the first key character

        for i in range(1, m):
            for j in range(n):
                for k in range(n):
                    if ring[k] == key[i]:
                        dp[i][j] = min(dp[i][j], dp[i - 1][k] + min(abs(j - k), n - abs(j - k)) + 1)

        return min(dp[m - 1])