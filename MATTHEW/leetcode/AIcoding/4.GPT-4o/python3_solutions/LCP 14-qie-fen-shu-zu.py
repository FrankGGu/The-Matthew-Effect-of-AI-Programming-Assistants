class Solution:
    def canSplitArray(self, nums: List[int], m: int) -> bool:
        if len(nums) < 3:
            return True
        for i in range(1, len(nums)):
            if nums[i] + nums[i-1] >= m:
                return True
        return False