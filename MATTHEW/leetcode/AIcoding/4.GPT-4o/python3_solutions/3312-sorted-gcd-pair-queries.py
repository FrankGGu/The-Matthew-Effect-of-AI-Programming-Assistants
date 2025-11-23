class Solution:
    def gcdQueries(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        from math import gcd
        from functools import reduce

        def gcd_of_subarray(l, r):
            return reduce(gcd, nums[l:r+1])

        return [gcd_of_subarray(l, r) for l, r in queries]