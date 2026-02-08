class Solution:
    def unequalTriplets(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        keys = list(count.keys())
        total_triplets = 0
        prefix_sum = 0
        suffix_sum = len(nums)

        for key in keys:
            suffix_sum -= count[key]
            total_triplets += prefix_sum * count[key] * suffix_sum
            prefix_sum += count[key]

        return total_triplets