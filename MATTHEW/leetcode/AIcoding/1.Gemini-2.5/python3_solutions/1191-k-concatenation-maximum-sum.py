from typing import List

class Solution:
    def kConcatenationMaxSum(self, arr: List[int], k: int) -> int:
        MOD = 10**9 + 7

        def kadane(nums):
            # This Kadane's algorithm returns the maximum subarray sum.
            # It handles cases where all numbers are negative by returning 0,
            # effectively choosing an empty subarray if all non-empty subarrays have negative sums.
            current_max = 0
            global_max = 0
            for x in nums:
                current_max += x
                global_max = max(global_max, current_max)
                if current_max < 0:
                    current_max = 0
            return global_max

        total_sum = sum(arr)

        # Case 1: k = 1
        # The problem reduces to finding the maximum subarray sum of the original array.
        if k == 1:
            return kadane(arr) % MOD

        # Case 2: k > 1
        # Calculate the maximum subarray sum for the array concatenated twice (arr + arr).
        # This covers all potential maximum subarrays that might span across the boundary
        # of the first and second 'arr' block, or are entirely within one of them.
        max_double_arr_sum = kadane(arr + arr)

        if total_sum > 0:
            # If the total sum of the original array is positive,
            # we can potentially increase the maximum sum by adding (k-2) full copies of 'arr'.
            # The max_double_arr_sum already accounts for the best sum from two concatenations.
            # For k > 2, we add (k-2) * total_sum to this.
            # Since total_sum > 0, this value will be greater than or equal to max_double_arr_sum.
            # The kadane function already ensures the result is non-negative.
            result = (max_double_arr_sum + (k - 2) * total_sum) % MOD
            return result
        else:
            # If the total sum of the original array is non-positive (zero or negative),
            # adding more copies of 'arr' (beyond the first two) will not increase the sum,
            # or will decrease it. Therefore, the maximum sum must be found within the first
            # two concatenations (arr + arr).
            # The kadane function already ensures the result is non-negative.
            return max_double_arr_sum % MOD