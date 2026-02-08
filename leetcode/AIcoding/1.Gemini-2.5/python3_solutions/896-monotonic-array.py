class Solution:
    def isMonotonic(self, nums: list[int]) -> bool:
        if len(nums) <= 1:
            return True

        is_increasing = True
        is_decreasing = True

        for i in range(1, len(nums)):
            if nums[i] > nums[i-1]:
                is_decreasing = False
            elif nums[i] < nums[i-1]:
                is_increasing = False

            if not is_increasing and not is_decreasing:
                return False

        return True