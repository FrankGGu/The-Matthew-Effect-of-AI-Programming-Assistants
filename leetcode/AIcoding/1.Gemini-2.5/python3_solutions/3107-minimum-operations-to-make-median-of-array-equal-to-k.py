class Solution:
    def minOperationsToMakeMedianK(self, nums: list[int], k: int) -> int:
        nums.sort()
        n = len(nums)
        median_idx = (n - 1) // 2

        operations = 0

        # Step 1: Make the median element equal to k.
        # The cost is the absolute difference.
        operations += abs(nums[median_idx] - k)

        # Step 2: Adjust elements to the left or right of the median
        # to ensure k remains the median at median_idx.

        # If the original median was less than k, we increased it to k.
        # Now, all elements to the right of median_idx must be at least k.
        # If any element nums[i] (i > median_idx) is less than k, we must increase it to k.
        if nums[median_idx] < k:
            for i in range(median_idx + 1, n):
                if nums[i] < k:
                    operations += (k - nums[i])
                else:
                    # Since the array is sorted, if nums[i] >= k,
                    # all subsequent elements nums[j] (j > i) will also be >= k.
                    # So we can break early.
                    break

        # If the original median was greater than k, we decreased it to k.
        # Now, all elements to the left of median_idx must be at most k.
        # If any element nums[i] (i < median_idx) is greater than k, we must decrease it to k.
        elif nums[median_idx] > k:
            for i in range(median_idx - 1, -1, -1):
                if nums[i] > k:
                    operations += (nums[i] - k)
                else:
                    # Since the array is sorted, if nums[i] <= k,
                    # all subsequent elements nums[j] (j < i) will also be <= k.
                    # So we can break early.
                    break

        return operations