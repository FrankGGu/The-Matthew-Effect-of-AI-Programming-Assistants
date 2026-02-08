import math

class Solution:
    def findGCD(self, nums: list[int]) -> int:
        min_val = min(nums)
        max_val = max(nums)
        return math.gcd(min_val, max_val)