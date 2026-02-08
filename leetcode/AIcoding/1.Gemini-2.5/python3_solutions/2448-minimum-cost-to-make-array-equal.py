class Solution:
    def minCost(self, nums: list[int], cost: list[int]) -> int:
        # Step 1: Pair each number with its corresponding cost
        # Step 2: Sort these pairs based on the numbers (nums[i])
        # This sorting is crucial because the weighted median concept relies on ordered data.
        pairs = sorted(zip(nums, cost))

        # Step 3: Calculate the total sum of all costs (total weight)
        total_cost_sum = sum(cost)

        # Step 4: Find the weighted median
        # The weighted median is the target value 'x' that minimizes the total cost.
        # It is the first 'num' value where the cumulative sum of costs reaches or exceeds
        # half of the total_cost_sum.

        current_cost_sum = 0
        weighted_median = 0

        for num, c in pairs:
            current_cost_sum += c
            # If current_cost_sum * 2 >= total_cost_sum, it means we have accumulated
            # at least half of the total weight. This 'num' is our weighted median.
            if current_cost_sum * 2 >= total_cost_sum:
                weighted_median = num
                break

        # Step 5: Calculate the minimum total cost using the identified weighted median
        min_total_cost = 0
        for num, c in pairs:
            min_total_cost += c * abs(num - weighted_median)

        return min_total_cost