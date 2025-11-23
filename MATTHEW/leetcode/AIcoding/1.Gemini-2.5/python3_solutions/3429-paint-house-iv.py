import math

class Solution:
    def minCost(self, houses: list[int], cost: list[list[int]], m: int, n: int, target: int) -> int:
        # dp[j][k] represents the minimum cost to paint houses up to the current house,
        # with the current house painted color j, and forming k neighborhoods.
        # We use two DP tables (prev_dp and curr_dp) to optimize space to O(n * target).

        # Initialize prev_dp with infinity.
        # prev_dp[j][k] stores the minimum cost for the previous house (i-1).
        prev_dp = [[math.inf] * (target + 1) for _ in range(n)]

        # Base case: painting the first house (house 0)
        for j in range(n):  # Iterate through all possible colors (0 to n-1)
            # If house 0 is already painted and its color is not j+1, we cannot paint it color j+1.
            # So, this state remains infinity.
            if houses[0] != 0 and houses[0] - 1 != j:
                continue

            # Calculate the cost for painting house 0 with color j+1.
            # If it's pre-painted, the cost is 0. Otherwise, it's from the cost matrix.
            current_paint_cost = 0
            if houses[0] == 0:  # If house 0 is not pre-painted
                current_paint_cost = cost[0][j]

            # The first house always forms 1 neighborhood.
            prev_dp[j][1] = current_paint_cost

        # Iterate through houses from the second house (index 1) up to the last house (m-1)
        for i in range(1, m):
            # Initialize curr_dp for the current house (i) with infinity.
            # curr_dp[j][k] will store results for house i.
            curr_dp = [[math.inf] * (target + 1) for _ in range(n)]

            # Precompute the two smallest costs and their corresponding color indices
            # from prev_dp for each possible number of neighborhoods (k_prev).
            # This optimization helps to find min(dp[i-1][prev_j'][k-1]) in O(1) time.
            # min_costs_for_k_prev will be a list of tuples: ((min1_val, min1_idx), (min2_val, min2_idx))
            min_costs_for_k_prev = []
            for k_prev in range(target + 1):
                min1_val, min1_idx = math.inf, -1  # Smallest cost and its color index
                min2_val, min2_idx = math.inf, -1  # Second smallest cost and its color index

                for prev_j in range(n):  # Iterate through all colors for the previous house
                    current_val = prev_dp[prev_j][k_prev]
                    if current_val < min1_val:
                        # Found a new smallest value, old min1 becomes min2
                        min2_val, min2_idx = min1_val, min1_idx
                        min1_val, min1_idx = current_val, prev_j
                    elif current_val < min2_val:
                        # Found a new second smallest value
                        min2_val, min2_idx = current_val, prev_j

                min_costs_for_k_prev.append(((min1_val, min1_idx), (min2_val, min2_idx)))

            # Iterate for current house i, current color j, and current neighborhoods k
            for j in range(n):  # Current house i painted color j+1
                # If house i is pre-painted and its color is not j+1, skip this state.
                if houses[i] != 0 and houses[i] - 1 != j:
                    continue

                # Calculate the cost for painting current house i with color j+1.
                current_paint_cost = 0
                if houses[i] == 0:  # If not pre-painted
                    current_paint_cost = cost[i][j]

                for k in range(1, target + 1):  # Current number of neighborhoods
                    # Case 1: Current house has the same color as the previous house (prev_j == j).
                    # This means the number of neighborhoods k remains the same.
                    if prev_dp[j][k] != math.inf:
                        curr_dp[j][k] = min(curr_dp[j][k], prev_dp[j][k] + current_paint_cost)

                    # Case 2: Current house has a different color from the previous house (prev_j != j).
                    # This means a new neighborhood is formed. So, we need k-1 neighborhoods from previous houses.
                    if k > 1:  # A new neighborhood can only be formed if k is at least 2.
                        min1, min2 = min_costs_for_k_prev[k - 1] # Get min1 and min2 for k-1 neighborhoods

                        cost_from_prev_diff_color = math.inf
                        if j == min1[1]:
                            # If the current color 'j' is the same as the color that yielded the overall minimum (min1)
                            # for k-1 neighborhoods, we must use the second minimum (min2) to ensure a different color.
                            cost_from_prev_diff_color = min2[0]
                        else:
                            # Otherwise, the current color 'j' is different from min1's color,
                            # so we can use the overall minimum (min1).
                            cost_from_prev_diff_color = min1[0]

                        if cost_from_prev_diff_color != math.inf:
                            curr_dp[j][k] = min(curr_dp[j][k], cost_from_prev_diff_color + current_paint_cost)

            # After processing all colors and neighborhoods for the current house 'i',
            # update prev_dp to curr_dp for the next iteration.
            prev_dp = curr_dp

        # After iterating through all houses, find the minimum cost among all possible colors
        # for the last house (m-1) with exactly 'target' neighborhoods.
        min_total_cost = math.inf
        for j in range(n):
            min_total_cost = min(min_total_cost, prev_dp[j][target])

        # If min_total_cost is still infinity, it means it's impossible to achieve the target.
        if min_total_cost == math.inf:
            return -1
        else:
            return min_total_cost