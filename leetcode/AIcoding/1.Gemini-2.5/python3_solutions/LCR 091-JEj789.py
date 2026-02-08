class Solution:
    def minCost(self, costs: list[list[int]]) -> int:
        if not costs:
            return 0

        # Initialize dp values for the "previous" house (conceptually, before the first house)
        # If there's no previous house, the cost to paint it any color is 0.
        prev_dp0 = 0
        prev_dp1 = 0
        prev_dp2 = 0

        for i in range(len(costs)):
            # Costs for painting the current house 'i' with each color
            current_cost0 = costs[i][0]
            current_cost1 = costs[i][1]
            current_cost2 = costs[i][2]

            # Calculate dp values for the current house 'i'
            # To paint house 'i' with color 0, add its cost to the minimum cost of painting house 'i-1' with color 1 or 2.
            dp0 = current_cost0 + min(prev_dp1, prev_dp2)
            # To paint house 'i' with color 1, add its cost to the minimum cost of painting house 'i-1' with color 0 or 2.
            dp1 = current_cost1 + min(prev_dp0, prev_dp2)
            # To paint house 'i' with color 2, add its cost to the minimum cost of painting house 'i-1' with color 0 or 1.
            dp2 = current_cost2 + min(prev_dp0, prev_dp1)

            # Update previous dp values for the next iteration
            prev_dp0 = dp0
            prev_dp1 = dp1
            prev_dp2 = dp2

        # The minimum cost to paint all houses is the minimum of the costs to paint the last house with any color.
        return min(prev_dp0, prev_dp1, prev_dp2)