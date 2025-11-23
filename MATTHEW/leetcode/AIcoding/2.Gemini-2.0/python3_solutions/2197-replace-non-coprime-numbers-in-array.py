import math

class Solution:
    def replaceNonCoprime(self, nums: list[int]) -> list[int]:
        stack = []
        for num in nums:
            while stack and math.gcd(stack[-1], num) > 1:
                num = math.lcm(stack[-1], num)
                stack.pop()
            stack.append(num)
        return stack