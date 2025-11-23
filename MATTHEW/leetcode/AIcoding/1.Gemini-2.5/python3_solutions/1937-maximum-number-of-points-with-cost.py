import math

class Solution:
    def maxPoints(self, points: list[list[int]]) -> int:
        m = len(points)
        n = len(points[0])

        dp = [0] * n
        for j in range(n):
            dp[j] = points[0][j]

        for i in range(1, m):
            current_dp = [0] * n

            # Calculate maximum from left side
            left_max = -math.inf
            for j in range(n):
                left_max = max(left_max, dp[j] + j)
                current_dp[j] = left_max - j

            # Calculate maximum from right side and combine
            right_max = -math.inf
            for j in range(n - 1, -1, -1):
                right_max = max(right_max, dp[j] - j)
                current_dp[j] = max(current_dp[j], right_max + j)

            # Add current row's points and update dp for the next iteration
            for j in range(n):
                dp[j] = current_dp[j] + points[i][j]

        return max(dp)