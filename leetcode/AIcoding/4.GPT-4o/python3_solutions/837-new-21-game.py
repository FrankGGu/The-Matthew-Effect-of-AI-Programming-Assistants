class Solution:
    def new21Game(self, N: int, K: int, W: int) -> float:
        if K == 0 or N >= K:
            return 1.0
        dp = [0.0] * (N + 1)
        dp[0] = 1.0
        window_sum = dp[0]
        for i in range(1, N + 1):
            dp[i] = window_sum / W
            if i < K:
                window_sum += dp[i]
            if i - W >= 0:
                window_sum -= dp[i - W]
        return sum(dp[K:N + 1])