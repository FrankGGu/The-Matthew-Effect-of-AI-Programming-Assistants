import math

class Solution:
    def maxSumDivisibleByK(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # Initialize max_sum to negative infinity to handle cases where all sums are negative
        max_sum = -math.inf

        # min_prefix_sum_at_rem[r] stores the minimum prefix sum P[x] encountered so far
        # such that x % k == r.
        # P[x] is the sum of nums[0...x-1].
        # P[0] = 0 (sum of an empty prefix).
        min_prefix_sum_at_rem = [math.inf] * k
        min_prefix_sum_at_rem[0] = 0

        current_prefix_sum = 0

        # Iterate through the array, calculating prefix sums
        # For each j, current_prefix_sum represents P[j+1]
        for j in range(n):
            current_prefix_sum += nums[j]

            # The length of the subarray nums[i...j] is (j - i + 1).
            # We need (j - i + 1) % k == 0.
            # This implies (j + 1) % k == i % k.
            # So, we need to find a P[i] such that i % k == (j + 1) % k.
            # To maximize P[j+1] - P[i], we need to minimize P[i].

            target_remainder_for_i = (j + 1) % k

            # If we have encountered a prefix sum P[i] with the required remainder
            if min_prefix_sum_at_rem[target_remainder_for_i] != math.inf:
                # Calculate the sum of the subarray nums[i...j]
                subarray_sum = current_prefix_sum - min_prefix_sum_at_rem[target_remainder_for_i]
                max_sum = max(max_sum, subarray_sum)

            # Update min_prefix_sum_at_rem for the current prefix sum P[j+1]
            current_prefix_sum_remainder = (j + 1) % k
            min_prefix_sum_at_rem[current_prefix_sum_remainder] = min(
                min_prefix_sum_at_rem[current_prefix_sum_remainder],
                current_prefix_sum
            )

        return max_sum