class Solution:
    def maxSubsequence(self, nums: List[int], k: int) -> List[int]:
        return sorted(nums, reverse=True)[:k]