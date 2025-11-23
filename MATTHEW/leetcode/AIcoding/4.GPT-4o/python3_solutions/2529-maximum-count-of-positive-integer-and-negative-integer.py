class Solution:
    def maximumCount(self, nums: List[int]) -> int:
        positive_count = sum(1 for x in nums if x > 0)
        negative_count = sum(1 for x in nums if x < 0)
        return max(positive_count, negative_count)