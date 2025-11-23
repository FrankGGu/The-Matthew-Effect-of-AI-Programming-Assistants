class Solution:
    def smallestRangeI(self, nums: list[int], k: int) -> int:
        min_val = nums[0]
        max_val = nums[0]

        for i in range(1, len(nums)):
            if nums[i] < min_val:
                min_val = nums[i]
            if nums[i] > max_val:
                max_val = nums[i]

        # Alternatively, using built-in min/max for lists:
        # min_val = min(nums)
        # max_val = max(nums)

        # The smallest element can be increased by at most k, becoming min_val + k.
        # The largest element can be decreased by at most k, becoming max_val - k.
        # To minimize the range, we want to make the new minimum as large as possible
        # and the new maximum as small as possible.
        # The new effective minimum for the array will be at least (min_val + k).
        # The new effective maximum for the array will be at most (max_val - k).
        # The smallest possible difference is (max_val - k) - (min_val + k).
        # If this difference is negative, it means the range can be collapsed to 0.

        potential_diff = (max_val - k) - (min_val + k)

        return max(0, potential_diff)