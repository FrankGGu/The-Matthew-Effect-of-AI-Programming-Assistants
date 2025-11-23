class Solution:
    def firstMissingPositive(self, nums: list[int]) -> int:
        n = len(nums)

        # Phase 1: Place each positive number x at index x-1 if possible
        i = 0
        while i < n:
            # Current number is nums[i]
            # It should ideally be at index nums[i] - 1
            correct_idx = nums[i] - 1

            # Check if nums[i] is a positive number within the range [1, n]
            # and if it is not already in its correct position
            if 1 <= nums[i] <= n and nums[correct_idx] != nums[i]:
                # Swap nums[i] with the number at its correct_idx
                nums[i], nums[correct_idx] = nums[correct_idx], nums[i]
            else:
                # If nums[i] is out of range, negative, zero, or already in place,
                # move to the next element
                i += 1

        # Phase 2: Find the first index i where nums[i] is not equal to i + 1
        for i in range(n):
            if nums[i] != i + 1:
                return i + 1

        # If all numbers from 1 to n are present, then the first missing positive is n + 1
        return n + 1