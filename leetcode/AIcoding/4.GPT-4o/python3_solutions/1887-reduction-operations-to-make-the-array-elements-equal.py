class Solution:
    def reductionOperations(self, nums: List[int]) -> int:
        nums.sort()
        count = 0
        for i in range(1, len(nums)):
            count += i * (nums[i] != nums[i - 1])
        return count