import collections

class Solution:
    def frequencySort(self, nums: list[int]) -> list[int]:
        counts = collections.Counter(nums)

        # Sort based on frequency (ascending) then value (descending)
        nums.sort(key=lambda x: (counts[x], -x))

        return nums