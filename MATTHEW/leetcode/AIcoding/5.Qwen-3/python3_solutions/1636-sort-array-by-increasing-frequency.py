class Solution:
    def frequencySort(self, nums: List[int]) -> List[int]:
        from collections import Counter

        count = Counter(nums)
        return sorted(nums, key=lambda x: (count[x], x))