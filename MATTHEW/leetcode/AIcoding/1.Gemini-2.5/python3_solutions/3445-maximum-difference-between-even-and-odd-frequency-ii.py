class Solution:
    def maxDifferenceEvenOddFrequencyII(self, nums: list[int]) -> int:
        if not nums:
            return 0

        # Transform the first element: 1 for even, -1 for odd
        first_val = 1 if nums[0] % 2 == 0 else -1

        # Initialize variables for maximum subarray sum
        max_so_far = first_val
        current_max = first_val

        # Initialize variables for minimum subarray sum
        min_so_far = first_val
        current_min = first_val

        # Iterate through the array starting from the second element
        for i in range(1, len(nums)):
            # Transform the current element
            val = 1 if nums[i] % 2 == 0 else -1

            # Update current_max and max_so_far using Kadane's algorithm
            # current_max tracks the maximum sum ending at the current position
            current_max = max(val, current_max + val)
            # max_so_far tracks the overall maximum sum found so far
            max_so_far = max(max_so_far, current_max)

            # Update current_min and min_so_far using a similar logic
            # current_min tracks the minimum sum ending at the current position
            current_min = min(val, current_min + val)
            # min_so_far tracks the overall minimum sum found so far
            min_so_far = min(min_so_far, current_min)

        # The maximum absolute difference is the maximum of the absolute values
        # of the overall maximum sum and the overall minimum sum.
        # This covers cases where (even_freq - odd_freq) is largely positive
        # or largely negative.
        return max(abs(max_so_far), abs(min_so_far))