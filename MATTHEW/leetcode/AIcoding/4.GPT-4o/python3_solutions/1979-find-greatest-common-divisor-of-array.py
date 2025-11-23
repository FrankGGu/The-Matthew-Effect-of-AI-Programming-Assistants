import math
from functools import reduce

class Solution:
    def findGCD(self, nums: List[int]) -> int:
        return reduce(math.gcd, nums)