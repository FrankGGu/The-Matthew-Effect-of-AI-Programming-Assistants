import collections

class Solution:
    def maxFrequencyElements(self, nums: list[int]) -> int:
        freq_map = collections.Counter(nums)

        max_freq = 0
        for freq in freq_map.values():
            if freq > max_freq:
                max_freq = freq

        count_max_freq_elements = 0
        for freq in freq_map.values():
            if freq == max_freq:
                count_max_freq_elements += 1

        return count_max_freq_elements * max_freq