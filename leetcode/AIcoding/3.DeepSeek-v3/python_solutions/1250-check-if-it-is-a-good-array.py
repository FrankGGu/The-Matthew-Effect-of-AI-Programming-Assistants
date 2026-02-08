import math

class Solution:
    def isGoodArray(self, nums: List[int]) -> bool:
        current_gcd = nums[0]
        for num in nums[1:]:
            current_gcd = math.gcd(current_gcd, num)
            if current_gcd == 1:
                return True
        return current_gcd == 1