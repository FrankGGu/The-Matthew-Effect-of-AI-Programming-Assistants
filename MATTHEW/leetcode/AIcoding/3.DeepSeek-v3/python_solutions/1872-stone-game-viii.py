class Solution:
    def stoneGameVIII(self, stones: List[int]) -> int:
        n = len(stones)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + stones[i]

        dp = [0] * n
        dp[n-1] = prefix[n]

        for i in range(n-2, 0, -1):
            dp[i] = max(dp[i+1], prefix[i+1] - dp[i+1])

        return dp[1]