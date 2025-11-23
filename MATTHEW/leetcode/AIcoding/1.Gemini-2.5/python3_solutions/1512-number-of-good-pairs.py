from collections import Counter

class Solution:
    def numIdenticalPairs(self, nums: list[int]) -> int:
        count_map = Counter(nums)
        good_pairs = 0
        for num_count in count_map.values():
            if num_count > 1:
                good_pairs += (num_count * (num_count - 1)) // 2
        return good_pairs