import math

class Solution:
    def connectTwoGroups(self, cost: list[list[int]]) -> int:
        n = len(cost)
        m = len(cost[0])

        # Precompute the cost for a single point in Group 1 to connect to a specific subset of Group 2 points.
        # row_costs[i][mask_j] = sum(cost[i][k] for k where (mask_j >> k) & 1)
        row_costs = [[0] * (1 << m) for _ in range(n)]
        for i in range(n):
            for mask_j in range(1, 1 << m):  # mask_j cannot be 0, as a point must connect to at least one other point
                for j in range(m):
                    if (mask_j >> j) & 1:
                        row_costs[i][mask_j] += cost[i][j]

        # dp[mask] stores the minimum cost to connect the first 'i' points of Group 1
        # such that the set of Group 2 points covered is 'mask'.
        # We use space optimization, so dp represents dp[i] and next_dp represents dp[i+1].
        dp = [math.inf] * (1 << m)
        dp[0] = 0  # Base case: 0 Group 1 points connected, 0 Group 2 points covered, cost is 0.

        # Iterate through each point in Group 1
        for i in range(n):
            next_dp = [math.inf] * (1 << m)
            # Iterate through all possible masks for Group 2 points after connecting point 'i'
            for new_mask in range(1 << m):
                # Iterate through all possible 'prev_mask' which are submasks of 'new_mask'.
                # 'prev_mask' represents the Group 2 points covered by Group 1 points 0 to i-1.
                # 'current_connections_mask' represents the Group 2 points that point 'i' connects to.
                # current_connections_mask = new_mask ^ prev_mask.
                # This ensures that prev_mask | current_connections_mask = new_mask.

                submask = new_mask
                while True:
                    prev_mask = submask
                    current_connections_mask = new_mask ^ prev_mask

                    # Point 'i' must connect to at least one point in Group 2.
                    # So, current_connections_mask cannot be 0.
                    if current_connections_mask != 0:
                        if dp[prev_mask] != math.inf:
                            next_dp[new_mask] = min(next_dp[new_mask], dp[prev_mask] + row_costs[i][current_connections_mask])

                    if submask == 0:
                        break
                    submask = (submask - 1) & new_mask
            dp = next_dp

        # The final answer is the minimum cost to connect all 'n' Group 1 points
        # such that all 'm' Group 2 points are covered (mask = (1 << m) - 1).
        return dp[(1 << m) - 1]