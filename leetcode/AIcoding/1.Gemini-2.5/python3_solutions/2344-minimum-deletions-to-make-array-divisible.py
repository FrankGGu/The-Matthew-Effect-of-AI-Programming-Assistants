import math
from functools import reduce

class Solution:
    def minOperations(self, nums: list[int], numsDivide: list[int]) -> int:

        g = reduce(math.gcd, numsDivide)

        nums.sort()

        for i, num in enumerate(nums):
            if g % num == 0:
                return i

        return -1