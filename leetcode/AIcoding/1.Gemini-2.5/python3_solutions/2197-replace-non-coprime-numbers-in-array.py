import math

class Solution:
    def replaceNonCoprimes(self, nums: list[int]) -> list[int]:
        stack = []
        for num in nums:
            stack.append(num)
            while len(stack) >= 2:
                a = stack[-2]
                b = stack[-1]

                common_divisor = math.gcd(a, b)

                if common_divisor == 1:
                    # They are coprime, no merge needed with the current top
                    break
                else:
                    # They are not coprime, merge them
                    stack.pop() # Remove b
                    stack.pop() # Remove a

                    # Calculate LCM and push it back
                    # LCM(a, b) = (a * b) / GCD(a, b)
                    lcm_val = (a * b) // common_divisor
                    stack.append(lcm_val)

        return stack