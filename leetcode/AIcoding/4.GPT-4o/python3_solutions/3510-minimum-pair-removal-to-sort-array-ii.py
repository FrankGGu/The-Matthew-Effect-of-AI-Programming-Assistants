class Solution:
    def minimumPairRemovals(self, nums: List[int]) -> int:
        from collections import Counter
        from math import gcd
        from functools import reduce

        freq = Counter(nums)
        unique_nums = list(freq.keys())
        n = len(unique_nums)

        def lcm(a, b):
            return a * b // gcd(a, b)

        lcm_values = [reduce(lcm, (freq[x] for x in unique_nums if freq[x] > 0), 1)]

        return len(nums) - max(lcm_values)