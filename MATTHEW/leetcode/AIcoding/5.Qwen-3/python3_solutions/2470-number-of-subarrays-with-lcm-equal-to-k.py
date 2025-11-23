from math import gcd
from functools import reduce

class Solution:
    def numSubarrayLCM(self, nums: List[int], k: int) -> int:
        def lcm(a, b):
            return a * b // gcd(a, b)

        count = 0
        for i in range(len(nums)):
            current_lcm = nums[i]
            for j in range(i, len(nums)):
                current_lcm = lcm(current_lcm, nums[j])
                if current_lcm == k:
                    count += 1
                elif current_lcm > k:
                    break
        return count