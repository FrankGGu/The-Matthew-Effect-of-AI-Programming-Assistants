def gcd(a, b):
    if b == 0:
        return a
    return gcd(b, a % b)

class Solution:
    def isGoodArray(self, nums: List[int]) -> bool:
        result = 0
        for num in nums:
            result = gcd(result, num)
        return result == 1