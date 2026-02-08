class Solution:
    def maxSubarray(self, nums: List[int]) -> int:
        res = nums[0]
        curr_max = nums[0]
        for i in range(1, len(nums)):
            curr_max = max(nums[i], curr_max + nums[i])
            res = max(res, curr_max)
        return res