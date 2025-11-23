class Solution:
    def minCost(self, houses: list[int], cost: list[list[int]], m: int, n: int, target: int) -> int:
        # dp[i][j][k] represents the minimum cost to paint houses from 0 to i,
        # such that house i is painted with color j+1, and exactly k neighborhoods are formed.
        # i: house index (0 to m-1)
        # j: color index (0 to n-1)
        # k: number of neighborhoods (1 to target)

        # Initialize dp table with a large value representing infinity
        # Using float('inf') for convenience
        dp = [[[float('inf')] * (target + 1) for _ in range(n)] for _ in range(m)]

        # Base case: painting the first house (house 0)
        for j in range(n): # Iterate through all possible colors (0 to n-1)
            if houses[0] == 0: # If house 0 is unpainted
                dp[0][j][1] = cost[0][j]
            elif houses[0] == j + 1: # If house 0 is pre-painted with color j+1
                dp[0][j][1] = 0
            # If houses[0] is pre-painted with a different color, dp[0][j][1] remains infinity,
            # indicating this state is impossible.

        # Iterate through the remaining houses from 1 to m-1
        for i in range(1, m):
            # Iterate through the number of neighborhoods from 1 to target
            for k in range(1, target + 1):
                # Pre-calculate the minimum and second minimum costs from dp[i-1][p][k-1]
                # These values are used when forming a new neighborhood (k-1 -> k)
                min1_cost = float('inf')
                min1_color = -1 # Stores the color that achieved min1_cost
                min2_cost = float('inf')

                # This pre-calculation is only relevant if we are trying to form a new neighborhood (k > 1)
                if k > 1:
                    for p in range(n): # Iterate through all possible previous colors
                        val = dp[i-1][p][k-1]
                        if val < min1_cost:
                            min2_cost = min1_cost
                            min1_cost = val
                            min1_color = p
                        elif val < min2_cost:
                            min2_cost = val

                # Iterate through all possible colors for the current house (house i)
                for curr_color in range(n):
                    # If house i is already painted and its color conflicts with curr_color, skip this state
                    if houses[i] != 0 and houses[i] != curr_color + 1:
                        continue

                    # Determine the cost to paint house i with curr_color
                    current_house_paint_cost = 0
                    if houses[i] == 0: # If house i is unpainted, add its cost
                        current_house_paint_cost = cost[i][curr_color]

                    # Calculate the minimum cost from previous states
                    cost_from_prev_house = float('inf')

                    # Case 1: House i-1 was painted with the same color (curr_color)
                    # This means the number of neighborhoods remains k.
                    # We take the cost from dp[i-1][curr_color][k].
                    cost_from_prev_house = min(cost_from_prev_house, dp[i-1][curr_color][k])

                    # Case 2: House i-1 was painted with a different color than curr_color
                    # This means a new neighborhood is formed, so the previous state must have had k-1 neighborhoods.
                    # This is only possible if k > 1.
                    if k > 1:
                        if curr_color == min1_color:
                            # If curr_color is the color that achieved the overall minimum cost for k-1 neighborhoods,
                            # we must use the second minimum cost to ensure prev_color != curr_color.
                            cost_from_prev_house = min(cost_from_prev_house, min2_cost)
                        else:
                            # Otherwise, we can use the overall minimum cost for k-1 neighborhoods.
                            cost_from_prev_house = min(cost_from_prev_house, min1_cost)

                    # If a valid previous state was found, update dp[i][curr_color][k]
                    if cost_from_prev_house != float('inf'):
                        dp[i][curr_color][k] = cost_from_prev_house + current_house_paint_cost

        # After filling the DP table, find the minimum cost among all possible last colors
        # for the target number of neighborhoods at the last house (m-1).
        min_total_cost = float('inf')
        for j in range(n):
            min_total_cost = min(min_total_cost, dp[m-1][j][target])

        # If min_total_cost is still infinity, it means it's impossible to achieve the target, so return -1.
        return min_total_cost if min_total_cost != float('inf') else -1