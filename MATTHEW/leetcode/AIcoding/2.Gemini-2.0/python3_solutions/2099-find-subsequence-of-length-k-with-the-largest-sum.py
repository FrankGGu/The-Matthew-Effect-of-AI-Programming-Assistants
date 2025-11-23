class Solution:
    def maxSubsequence(self, nums: List[int], k: int) -> List[int]:
        indices = sorted(range(len(nums)), key=lambda i: nums[i], reverse=True)[:k]
        indices.sort()
        return [nums[i] for i in indices]