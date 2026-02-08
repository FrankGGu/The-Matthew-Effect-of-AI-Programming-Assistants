class Solution:
    def connectTwoGroups(self, cost: List[List[int]]) -> int:
        n, m = len(cost), len(cost[0])
        dp = [float('inf')] * (1 << m)
        dp[0] = 0
        for i in range(n):
            new_dp = [float('inf')] * (1 << m)
            for mask in range(1 << m):
                for j in range(m):
                    new_mask = mask | (1 << j)
                    new_dp[new_mask] = min(new_dp[new_mask], dp[mask] + cost[i][j])
                new_dp[mask] = min(new_dp[mask], dp[mask] + min(cost[i]))
            dp = new_dp
        return min(dp)