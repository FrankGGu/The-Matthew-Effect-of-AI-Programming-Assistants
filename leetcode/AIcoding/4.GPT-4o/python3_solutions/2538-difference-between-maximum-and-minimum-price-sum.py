class Solution:
    def maxDifference(self, nums: List[int]) -> int:
        max_price = max(nums)
        min_price = min(nums)
        return max_price - min_price