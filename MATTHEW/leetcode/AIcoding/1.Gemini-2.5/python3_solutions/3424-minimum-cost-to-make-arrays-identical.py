class Solution:
    def minCost(self, nums: list[int], cost: list[int]) -> int:
        n = len(nums)

        # Combine nums and cost into pairs and sort them by nums[i].
        # This is crucial for finding the weighted median efficiently.
        pairs = []
        for i in range(n):
            pairs.append((nums[i], cost[i]))

        # Sorts by the first element of the tuple (nums[i]) by default.
        pairs.sort() 

        # Calculate the total sum of all costs.
        total_cost_sum = sum(c for _, c in pairs)

        # Find the weighted median. The weighted median is the value 'x'
        # such that the cumulative cost of elements less than or equal to 'x'
        # is at least half of the total cost. This 'x' minimizes the sum
        # of weighted absolute differences.
        current_cost_sum = 0
        median_val = 0

        for num, c in pairs:
            current_cost_sum += c
            # When current_cost_sum reaches or exceeds half of the total cost,
            # the current 'num' is our weighted median.
            if current_cost_sum * 2 >= total_cost_sum:
                median_val = num
                break # We found the median, no need to check further.

        # Calculate the minimum total cost using the found median_val.
        min_total_cost = 0
        for num, c in pairs:
            min_total_cost += c * abs(num - median_val)

        return min_total_cost