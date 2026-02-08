class Solution:
    def new21Game(self, n: int, k: int, maxPts: int) -> float:
        if k == 0 or n >= k + maxPts:
            return 1.0
        dp = [0.0] * (n + 1)
        dp[0] = 1.0
        sum_prob = 1.0
        for i in range(1, n + 1):
            dp[i] = sum_prob / maxPts
            if i < k:
                sum_prob += dp[i]
            if i >= maxPts:
                sum_prob -= dp[i - maxPts]
        return sum(dp[k:])