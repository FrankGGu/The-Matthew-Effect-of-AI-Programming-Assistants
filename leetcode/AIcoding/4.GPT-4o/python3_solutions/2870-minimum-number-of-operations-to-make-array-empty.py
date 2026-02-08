class Solution:
    def minOperations(self, nums: List[int]) -> int:
        return max(nums) + 1 if nums else 0