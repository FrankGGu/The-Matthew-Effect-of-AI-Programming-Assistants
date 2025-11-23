class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        n = len(points)
        if n == 0:
            return 0

        dp = [0] * n

        for i in range(n):
            dp[i] = points[i][1]

        for i in range(1, n):
            for j in range(i):
                if points[j][0] < points[i][0]:
                    dp[i] = max(dp[i], dp[j] + points[i][1])

        return max(dp)