import collections

class Solution:
    def mincostTickets(self, days: list[int], costs: list[int]) -> int:
        max_day = days[-1]
        travel_days = set(days)

        dp = [0] * (max_day + 1)

        for i in range(1, max_day + 1):
            if i not in travel_days:
                dp[i] = dp[i-1]
            else:
                cost_1_day = dp[i-1] + costs[0]
                cost_7_day = dp[max(0, i-7)] + costs[1]
                cost_30_day = dp[max(0, i-30)] + costs[2]
                dp[i] = min(cost_1_day, cost_7_day, cost_30_day)

        return dp[max_day]