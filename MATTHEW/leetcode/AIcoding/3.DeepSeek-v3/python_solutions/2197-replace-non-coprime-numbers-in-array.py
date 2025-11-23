import math

class Solution:
    def replaceNonCoprimes(self, nums: List[int]) -> List[int]:
        stack = []
        for num in nums:
            current = num
            while stack:
                last = stack[-1]
                gcd_val = math.gcd(last, current)
                if gcd_val == 1:
                    break
                stack.pop()
                current = (last * current) // gcd_val
            stack.append(current)
        return stack