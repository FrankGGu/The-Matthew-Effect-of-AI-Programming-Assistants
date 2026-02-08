from math import gcd

class Solution:
    def splitArray(self, nums: list[int]) -> int:
        n = len(nums)
        left = [1] * n
        right = [1] * n

        factors = set()

        for i in range(n):
            num = nums[i]
            for factor in factors:
                if gcd(num, factor) > 1:
                    left[i] = 0
                    break
            factors.add(num)

        factors = set()

        for i in range(n - 1, -1, -1):
            num = nums[i]
            for factor in factors:
                if gcd(num, factor) > 1:
                    right[i] = 0
                    break
            factors.add(num)

        for i in range(n - 1):
            if left[i] == 1 and right[i + 1] == 1:
                return i + 1

        return -1