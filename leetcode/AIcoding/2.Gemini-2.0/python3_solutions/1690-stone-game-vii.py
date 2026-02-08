class Solution:
    def stoneGameVII(self, stones: List[int]) -> int:
        n = len(stones)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + stones[i]

        dp = [[0] * n for _ in range(n)]

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                dp[i][j] = max(prefix_sum[j + 1] - prefix_sum[i + 1] - dp[i + 1][j],
                               prefix_sum[j] - prefix_sum[i] - dp[i][j - 1])

        return dp[0][n - 1]