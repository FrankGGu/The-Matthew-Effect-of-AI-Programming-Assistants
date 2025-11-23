class Solution:
    def minOperations(self, nums: list[int]) -> int:
        operations = 0
        if len(nums) < 2:
            return 0

        for i in range(1, len(nums)):
            if nums[i] <= nums[i - 1]:
                increment_needed = (nums[i - 1] + 1) - nums[i]
                operations += increment_needed
                nums[i] = nums[i - 1] + 1

        return operations