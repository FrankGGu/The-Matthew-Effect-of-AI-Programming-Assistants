import math
from functools import reduce

class Solution:
    def minOperations(self, nums: List[int], numsDivide: List[int]) -> int:
        def compute_gcd(arr):
            return reduce(math.gcd, arr)

        x = compute_gcd(numsDivide)
        nums.sort()
        for i, num in enumerate(nums):
            if x % num == 0:
                return i
        return -1