class Solution:
    def minSideJumps(self, obstacles: list[int]) -> int:
        dp = [1, 0, 1]
        for obs in obstacles[1:]:
            if obs != 0:
                dp[obs - 1] = float('inf')
            for i in range(3):
                if dp[i] == float('inf'):
                    continue
                dp[i] = min(dp[i], min(dp[(i + 1) % 3] + 1, dp[(i + 2) % 3] + 1))
            for i in range(3):
                if obs == i + 1:
                    dp[i] = float('inf')
        return min(dp)