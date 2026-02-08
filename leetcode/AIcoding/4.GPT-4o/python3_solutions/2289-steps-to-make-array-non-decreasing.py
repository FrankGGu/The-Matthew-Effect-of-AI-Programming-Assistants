class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        operations = 0
        for i in range(1, len(nums)):
            if nums[i] < nums[i - 1]:
                operations += nums[i - 1] - nums[i]
                nums[i] = nums[i - 1]
        return operations