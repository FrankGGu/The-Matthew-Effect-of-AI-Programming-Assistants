import math
from collections import deque

class Solution:
    def minSkips(self, dist, speed, hoursBefore):
        n = len(dist)
        dp = [[math.inf] * (n + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(i + 1):
                travel_time = math.ceil(dist[i - 1] / speed)
                if j > 0:
                    dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + travel_time)
                if j < i:
                    dp[i][j] = min(dp[i][j], dp[i - 1][j] + travel_time)
                dp[i][j] = min(dp[i][j], dp[i - 1][j] + travel_time)

        for j in range(n + 1):
            if dp[n][j] <= hoursBefore:
                return j
        return n