class Solution:
    def maxSubarraySumCircular(self, nums: list[int]) -> int:
        total_sum = 0

        current_max = 0
        max_so_far = float('-inf')

        current_min = 0
        min_so_far = float('inf')

        for x in nums:
            total_sum += x

            # Kadane's algorithm to find maximum subarray sum
            current_max = max(x, current_max + x)
            max_so_far = max(max_so_far, current_max)

            # Kadane's algorithm to find minimum subarray sum
            current_min = min(x, current_min + x)
            min_so_far = min(min_so_far, current_min)

        # If max_so_far is negative, it means all numbers in nums are negative.
        # In this case, the maximum sum is the largest single element (max_so_far).
        # The circular sum (total_sum - min_so_far) would be 0, which is incorrect.
        if max_so_far < 0:
            return max_so_far
        else:
            # The result is the maximum of:
            # 1. The maximum non-circular subarray sum (max_so_far)
            # 2. The maximum circular subarray sum (total_sum - min_so_far)
            #    This represents taking the total sum and removing the minimum subarray sum,
            #    which effectively gives the sum of the elements at the ends of the array.
            return max(max_so_far, total_sum - min_so_far)