class Solution:
    def minCost(self, stones: List[int]) -> int:
        n = len(stones)
        if n <= 1:
            return 0
        dp = [0] * n
        dp[1] = abs(stones[1] - stones[0])
        for i in range(2, n):
            dp[i] = min(dp[i-1] + abs(stones[i] - stones[i-1]), dp[i-2] + abs(stones[i] - stones[i-2]))
        return dp[-1]