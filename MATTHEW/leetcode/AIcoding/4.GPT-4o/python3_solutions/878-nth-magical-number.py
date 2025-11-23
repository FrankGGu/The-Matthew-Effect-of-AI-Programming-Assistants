class Solution:
    def nthMagicalNumber(self, n: int, a: int, b: int) -> int:
        import math

        lcm = a * b // math.gcd(a, b)
        left, right = 1, n * lcm

        while left < right:
            mid = (left + right) // 2
            if mid // a + mid // b - mid // lcm < n:
                left = mid + 1
            else:
                right = mid

        return left % (10**9 + 7)