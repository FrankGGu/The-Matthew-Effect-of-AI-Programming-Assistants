from collections import Counter

class Solution:
    def maxFrequencyElements(self, nums: List[int]) -> int:
        counts = Counter(nums)
        max_freq = max(counts.values())
        count = 0
        for freq in counts.values():
            if freq == max_freq:
                count += freq
        return count