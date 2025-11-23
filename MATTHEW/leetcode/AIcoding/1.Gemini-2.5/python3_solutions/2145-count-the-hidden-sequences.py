class Solution:
    def numberOfHiddenSequences(self, differences: list[int], lower: int, upper: int) -> int:
        min_prefix_sum = 0
        max_prefix_sum = 0
        current_prefix_sum = 0

        for diff in differences:
            current_prefix_sum += diff
            min_prefix_sum = min(min_prefix_sum, current_prefix_sum)
            max_prefix_sum = max(max_prefix_sum, current_prefix_sum)

        # The range for b[0] is [lower_bound_x, upper_bound_x]
        # lower <= b[0] + P[i] <= upper
        # lower - P[i] <= b[0] <= upper - P[i]
        # So, b[0] must be >= max(lower - P[i]) = lower - min(P[i]) = lower - min_prefix_sum
        # And, b[0] must be <= min(upper - P[i]) = upper - max(P[i]) = upper - max_prefix_sum

        lower_bound_x = lower - min_prefix_sum
        upper_bound_x = upper - max_prefix_sum

        # The number of integers x in [lower_bound_x, upper_bound_x] is upper_bound_x - lower_bound_x + 1
        # If upper_bound_x < lower_bound_x, there are no solutions, so the count is 0.
        return max(0, upper_bound_x - lower_bound_x + 1)