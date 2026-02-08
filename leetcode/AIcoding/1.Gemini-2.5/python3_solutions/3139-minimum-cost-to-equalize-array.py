import math

class Solution:
    def minCost(self, nums: list[int], cost: list[int], baseCost: int) -> int:
        n = len(nums)

        # Create pairs of (num, cost) and sort them by num
        items = sorted([(nums[i], cost[i]) for i in range(n)])

        # Calculate initial total cost for the smallest num value (items[0][0])
        # This will be our initial candidate for the target value x
        current_x_val = items[0][0]
        current_total_cost = 0

        # left_sum represents sum of (cost[k] + baseCost) for nums[k] <= current_x_val
        # right_sum represents sum of cost[k] for nums[k] > current_x_val
        # Initially, for x = items[0][0]:
        #   left_sum is 0 (no elements are strictly less than items[0][0])
        #   right_sum is sum of all costs (all elements are >= items[0][0], so for those > items[0][0], they contribute to right_sum)
        left_sum_coeffs = 0
        right_sum_coeffs = sum(c for _, c in items)

        # Calculate initial cost for x = current_x_val (items[0][0])
        # For elements nums[k] > current_x_val, cost is (nums[k] - current_x_val) * cost[k]
        for val, c in items:
            current_total_cost += (val - current_x_val) * c

        min_total_cost = current_total_cost

        # Iterate through unique num values as potential target x values
        i = 0
        while i < n:
            x_val = items[i][0]

            # Update min_total_cost with the cost at current x_val
            min_total_cost = min(min_total_cost, current_total_cost)

            # Find all items with the same x_val
            j = i
            cost_sum_at_x_val = 0  # Sum of costs for elements equal to x_val
            count_at_x_val = 0     # Count of elements equal to x_val
            while j < n and items[j][0] == x_val:
                cost_sum_at_x_val += items[j][1]
                count_at_x_val += 1
                j += 1

            # If this is the last unique x_val, we are done
            if j == n:
                break

            # Calculate the next unique x_val and the distance
            next_x_val = items[j][0]
            delta_x = next_x_val - x_val

            # Update slope coefficients for the interval (x_val, next_x_val)
            # Elements that were at x_val now effectively become "less than x" for the next interval.
            # So, they contribute to left_sum_coeffs (cost + baseCost)
            # And they are removed from right_sum_coeffs (cost)
            left_sum_coeffs += cost_sum_at_x_val + count_at_x_val * baseCost
            right_sum_coeffs -= cost_sum_at_x_val

            # Update current_total_cost for next_x_val using the current slope
            # The slope of the cost function f(x) for x in (x_val, next_x_val) is (left_sum_coeffs - right_sum_coeffs)
            current_total_cost += (left_sum_coeffs - right_sum_coeffs) * delta_x

            # Move to the next distinct x_val
            i = j

        return min_total_cost