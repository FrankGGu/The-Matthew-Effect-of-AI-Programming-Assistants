class Solution:
    def minimumPairRemovals(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        max_freq = max(count.values())

        return len(nums) - max_freq