class Solution:
    def minOperations(self, nums: List[int]) -> int:
        return max(nums) - min(nums)