from collections import Counter
from math import gcd
from functools import reduce

class Solution:
    def countSubsequences(self, nums: List[int], gcdThreshold: int) -> int:
        nums.sort()
        count = 0
        mod = 10**9 + 7

        def count_valid_subsequences(g):
            total_count = 0
            for num in nums:
                if num < g:
                    continue
                if num % g == 0:
                    total_count += 1
            return (1 << total_count) - 1 if total_count > 0 else 0

        for g in range(1, gcdThreshold + 1):
            if all(num % g == 0 for num in nums):
                count = (count + count_valid_subsequences(g)) % mod

        return count