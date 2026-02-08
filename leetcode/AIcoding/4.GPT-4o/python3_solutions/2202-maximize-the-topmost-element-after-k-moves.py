class Solution:
    def maxTop(self, nums: List[int], k: int) -> int:
        if not nums:
            return -1
        if k == 0:
            return nums[0]
        if k >= len(nums):
            return max(nums)
        return max(nums[:k] + nums[k+1:k+2]) if k < len(nums) else max(nums)