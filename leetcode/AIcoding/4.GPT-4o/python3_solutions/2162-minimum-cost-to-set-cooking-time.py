class Solution:
    def minCost(self, time: int, costs: List[int]) -> int:
        n = len(costs)
        dp = [float('inf')] * (time + 1)
        dp[0] = 0

        for cost in costs:
            for t in range(time, cost - 1, -1):
                dp[t] = min(dp[t], dp[t - cost] + cost)

        return dp[time] if dp[time] != float('inf') else -1