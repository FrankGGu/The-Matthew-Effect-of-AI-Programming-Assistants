from collections import Counter

class Solution:
    def numberOfPairs(self, nums: list[int]) -> list[int]:
        counts = Counter(nums)
        pairs = 0
        remainder = 0
        for count in counts.values():
            pairs += count // 2
            remainder += count % 2
        return [pairs, remainder]