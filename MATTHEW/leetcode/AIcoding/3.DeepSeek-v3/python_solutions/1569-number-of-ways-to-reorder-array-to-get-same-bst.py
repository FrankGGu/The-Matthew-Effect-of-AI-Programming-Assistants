import math

class Solution:
    def numOfWays(self, nums: List[int]) -> int:
        mod = 10**9 + 7

        def dfs(nums):
            if len(nums) <= 2:
                return 1
            left = [x for x in nums if x < nums[0]]
            right = [x for x in nums if x > nums[0]]
            return dfs(left) * dfs(right) * math.comb(len(left) + len(right), len(left)) % mod

        return (dfs(nums) - 1) % mod