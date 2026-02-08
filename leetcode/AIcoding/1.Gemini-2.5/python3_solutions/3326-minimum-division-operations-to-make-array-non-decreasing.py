class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        n = len(nums)
        if n <= 1:
            return 0

        operations = 0
        # current_max_val stores the maximum allowed value for nums[i]
        # to maintain non-decreasing order with the (potentially modified) element at i+1.
        # We process from right to left, so nums[n-1] is the initial upper bound.
        current_max_val = nums[n - 1] 

        # Iterate from the second-to-last element down to the first.
        for i in range(n - 2, -1, -1):
            if nums[i] > current_max_val:
                # If nums[i] is greater than the allowed maximum, we must perform an operation.
                # Each operation replaces nums[i] with floor(nums[i] / x) for some integer x >= 2.
                # We want to reduce nums[i] to a value V such that V <= current_max_val.
                # To minimize operations, we aim to achieve this in a single step if possible.
                # It is always possible in one step:
                # We need floor(nums[i] / x) <= current_max_val.
                # To make floor(nums[i] / x) as large as possible (to provide a less restrictive upper bound for nums[i-1]),
                # we should choose the smallest possible x that satisfies the condition.
                # From floor(nums[i] / x) <= current_max_val, we know nums[i] / x < current_max_val + 1.
                # This implies x > nums[i] / (current_max_val + 1).
                # The smallest integer x satisfying this is floor(nums[i] / (current_max_val + 1)) + 1.
                # This x is guaranteed to be >= 2 because nums[i] > current_max_val implies
                # nums[i] >= current_max_val + 1, so nums[i] / (current_max_val + 1) >= 1.
                # Thus, floor(nums[i] / (current_max_val + 1)) >= 1, and x >= 1 + 1 = 2.

                operations += 1

                # Calculate the optimal 'x' for this operation.
                # This 'x' ensures that the new value of nums[i] is <= current_max_val.
                x = nums[i] // (current_max_val + 1) + 1

                # The new value of nums[i] after this operation becomes the new upper bound
                # for the element at index i-1.
                current_max_val = nums[i] // x
            else:
                # If nums[i] is already less than or equal to current_max_val, no operation is needed.
                # The new current_max_val for the next iteration (nums[i-1]) becomes nums[i].
                current_max_val = nums[i]

        return operations