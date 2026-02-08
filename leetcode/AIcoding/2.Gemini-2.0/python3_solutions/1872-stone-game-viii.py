class Solution:
    def stoneGameVIII(self, stones: list[int]) -> int:
        n = len(stones)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + stones[i]

        dp = [0] * (n)
        dp[n - 1] = prefix_sum[n]

        for i in range(n - 2, 0, -1):
            dp[i] = max(prefix_sum[i + 1] - dp[i + 1], dp[i + 1])

        return dp[1]