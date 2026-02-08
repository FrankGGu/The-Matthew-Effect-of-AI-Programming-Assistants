import math

class Solution:
    def minSumOfLengths(self, arr: list[int], target: int) -> int:
        n = len(arr)
        prefix_sum_map = {0: -1}
        current_sum = 0

        # min_len_ending_at_or_before[i] stores the minimum length of a subarray
        # with sum 'target' that ends at or before index 'i'.
        min_len_ending_at_or_before = [math.inf] * n

        min_total_length = math.inf

        for i in range(n):
            current_sum += arr[i]

            # Update min_len_ending_at_or_before[i] based on the previous index
            if i > 0:
                min_len_ending_at_or_before[i] = min_len_ending_at_or_before[i-1]

            # Check if a subarray ending at 'i' with sum 'target' exists
            if (current_sum - target) in prefix_sum_map:
                start_idx = prefix_sum_map[current_sum - target] + 1
                current_subarray_length = i - start_idx + 1

                # If there's a valid subarray ending before 'start_idx',
                # we can potentially form two non-overlapping subarrays.
                if start_idx > 0 and min_len_ending_at_or_before[start_idx - 1] != math.inf:
                    min_total_length = min(min_total_length, 
                                           current_subarray_length + min_len_ending_at_or_before[start_idx - 1])

                # Update min_len_ending_at_or_before[i] with the length of the current subarray
                min_len_ending_at_or_before[i] = min(min_len_ending_at_or_before[i], current_subarray_length)

            prefix_sum_map[current_sum] = i

        return min_total_length if min_total_length != math.inf else -1