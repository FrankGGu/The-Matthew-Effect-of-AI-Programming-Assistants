from collections import Counter

class Solution:
    def minLengthAfterRemovals(self, nums: List[int]) -> int:
        counts = Counter(nums)
        max_count = max(counts.values())
        n = len(nums)
        if max_count > n // 2:
            return 2 * max_count - n
        else:
            return n % 2