from collections import defaultdict
from math import comb

class Solution:
    def numOfWays(self, nums: List[int]) -> int:
        def countWays(nums):
            if len(nums) <= 2:
                return 1
            root = nums[0]
            left = [x for x in nums if x < root]
            right = [x for x in nums if x > root]
            return countWays(left) * countWays(right) * comb(len(left) + len(right), len(left))

        return (countWays(nums) - 1) % (10**9 + 7)