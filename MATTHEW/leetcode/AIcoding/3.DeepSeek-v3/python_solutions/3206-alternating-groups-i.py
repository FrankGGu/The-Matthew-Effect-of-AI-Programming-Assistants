class Solution:
    def isAlternating(self, nums: List[int]) -> bool:
        if len(nums) < 2:
            return True
        for i in range(1, len(nums)):
            if nums[i] == nums[i-1]:
                return False
        return True