class Solution:
    def minArraySum(self, nums: List[int], k: int, a: int, b: int) -> int:
        from math import gcd

        def lcm(x, y):
            return x * y // gcd(x, y)

        def count(x, y, z):
            return (z - x) // y + 1

        total = 0
        for num in nums:
            if num % a == 0 or num % b == 0:
                total += num
            else:
                l = lcm(a, b)
                c = num % l
                if c == 0:
                    total += num
                else:
                    m = (l - c) % l
                    total += num + m
        return total