class Solution:
    def minimumWhiteTiles(self, floor: List[int], numCarpets: int, carpetLen: int) -> int:
        n = len(floor)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + floor[i]

        dp = [[float('inf')] * (numCarpets + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for k in range(numCarpets + 1):
                dp[i][k] = dp[i - 1][k] + floor[i - 1]
                if k > 0:
                    dp[i][k] = min(dp[i][k], dp[max(0, i - carpetLen)][k - 1])

        return dp[n][numCarpets]