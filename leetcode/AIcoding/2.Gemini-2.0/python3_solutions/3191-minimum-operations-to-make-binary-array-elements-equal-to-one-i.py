class Solution:
    def minOperations(self, nums: list[int]) -> int:
        count = 0
        for i in range(len(nums)):
            if nums[i] == 0:
                count += 1
        return count