class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        left = 0
        right = len(nums) - 1
        operations = 0

        while left < right:
            if nums[left] == 1 and nums[right] == 0:
                operations += 1
                left += 1
                right -= 1
            elif nums[left] == 0:
                left += 1
            elif nums[right] == 1:
                right -= 1
            else:
                left += 1
                right -= 1

        return operations