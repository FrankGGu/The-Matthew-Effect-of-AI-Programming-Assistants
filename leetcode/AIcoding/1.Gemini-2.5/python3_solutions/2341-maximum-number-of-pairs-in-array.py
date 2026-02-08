import collections

class Solution:
    def numberOfPairs(self, nums: list[int]) -> list[int]:
        counts = collections.Counter(nums)

        pairs = 0
        remaining = 0

        for count in counts.values():
            pairs += count // 2
            remaining += count % 2

        return [pairs, remaining]