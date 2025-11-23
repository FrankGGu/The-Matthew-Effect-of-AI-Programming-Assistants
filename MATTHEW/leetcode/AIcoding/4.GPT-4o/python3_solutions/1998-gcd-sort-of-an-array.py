from math import gcd
from collections import defaultdict

class Solution:
    def gcdSort(self, nums: List[int]) -> bool:
        def find_factors(num):
            factors = set()
            for i in range(1, int(num**0.5) + 1):
                if num % i == 0:
                    factors.add(i)
                    factors.add(num // i)
            return factors

        n = len(nums)
        fact_map = defaultdict(list)

        for i in range(n):
            factors = find_factors(nums[i])
            for factor in factors:
                fact_map[factor].append(nums[i])

        for key in fact_map:
            fact_map[key].sort()

        nums_sorted = sorted(nums)

        for i in range(n):
            for factor in find_factors(nums[i]):
                if fact_map[factor]:
                    nums[i] = fact_map[factor].pop(0)
                    break

        return nums == nums_sorted