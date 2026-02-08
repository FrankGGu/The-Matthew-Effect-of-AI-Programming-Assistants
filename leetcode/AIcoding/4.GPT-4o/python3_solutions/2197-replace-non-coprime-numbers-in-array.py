from math import gcd
from functools import reduce

class Solution:
    def findValidSplit(self, nums):
        n = len(nums)
        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            for j in range(i):
                if dp[j] and gcd(nums[j:i]) == 1:
                    dp[i] = 1
                    break

        return dp[n]