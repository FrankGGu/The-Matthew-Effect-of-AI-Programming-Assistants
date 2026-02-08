class Solution:
    def applyOperations(self, nums: List[int]) -> List[int]:
        n = len(nums)
        for i in range(n - 1):
            if nums[i] == nums[i + 1]:
                nums[i] *= 2
                nums[i + 1] = 0
        non_zero = [num for num in nums if num != 0]
        zero_count = len(nums) - len(non_zero)
        return non_zero + [0] * zero_count