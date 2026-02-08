class Solution:
    def paintWalls(self, cost: List[int], time: List[int]) -> int:
        n = len(cost)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(n):
            c, t = cost[i], time[i]
            for j in range(n, -1, -1):
                new_j = min(n, j + t + 1)
                if dp[j] + c < dp[new_j]:
                    dp[new_j] = dp[j] + c

        return dp[n]