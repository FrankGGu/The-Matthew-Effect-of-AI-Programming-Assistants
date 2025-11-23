from collections import Counter

class Solution:
    def frequencySort(self, nums: list[int]) -> list[int]:
        count = Counter(nums)
        return sorted(nums, key=lambda x: (count[x], -x))