from itertools import combinations

class Solution:
    def connectTwoGroups(self, cost: List[List[int]]) -> int:
        n, m = len(cost), len(cost[0])
        all_points = (1 << n) - 1
        dp = [float('inf')] * (1 << n)
        dp[0] = 0

        for j in range(m):
            new_dp = dp[:]
            for i in range(1 << n):
                if dp[i] == float('inf'):
                    continue
                for k in range(n):
                    if not (i & (1 << k)):
                        new_dp[i | (1 << k)] = min(new_dp[i | (1 << k)], dp[i] + cost[k][j])
            dp = new_dp

        return min(dp)