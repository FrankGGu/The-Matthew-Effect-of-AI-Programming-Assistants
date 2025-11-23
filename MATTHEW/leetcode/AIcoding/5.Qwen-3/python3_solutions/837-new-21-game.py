class Solution:
    def new21Game(self, N: int, K: int, maxPts: int) -> float:
        if K == 0:
            return 1.0
        dp = [0.0] * (K + maxPts)
        dp[K - 1] = 1.0
        for i in range(K - 1, -1, -1):
            dp[i] = dp[i + 1] + (dp[i + 1] - dp[i + maxPts + 1] if i + maxPts + 1 < len(dp) else 0)
        return sum(dp[:K])