from collections import Counter

class Solution:
    def findPairs(self, nums: list[int], k: int) -> int:
        count = 0
        if k == 0:
            freq_map = Counter(nums)
            for num_freq in freq_map.values():
                if num_freq >= 2:
                    count += 1
        else:
            unique_nums = set(nums)
            for num in unique_nums:
                if (num + k) in unique_nums:
                    count += 1

        return count