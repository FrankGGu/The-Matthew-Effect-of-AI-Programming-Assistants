class Solution:
    def minimumTotalDistance(self, robot: List[int], factory: List[List[int]]) -> int:
        dp = [float('inf')] * (len(robot) + 1)
        dp[0] = 0

        for a, b in factory:
            for j in range(len(robot), -1, -1):
                for k in range(1, min(a, j) + 1):
                    dp[j] = min(dp[j], dp[j - k] + k * b)

        return dp[len(robot)]