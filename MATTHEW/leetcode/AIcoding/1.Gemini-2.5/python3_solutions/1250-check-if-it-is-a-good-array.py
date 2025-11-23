import math

class Solution:
    def isGoodArray(self, nums: list[int]) -> bool:
        current_gcd = nums[0]
        for i in range(1, len(nums)):
            current_gcd = math.gcd(current_gcd, nums[i])
            if current_gcd == 1:
                return True
        return current_gcd == 1