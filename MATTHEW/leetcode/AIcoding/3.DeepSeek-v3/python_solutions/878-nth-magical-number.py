import math

class Solution:
    def nthMagicalNumber(self, n: int, a: int, b: int) -> int:
        MOD = 10**9 + 7
        lcm_ab = a * b // math.gcd(a, b)

        left = 0
        right = n * max(a, b)

        while left < right:
            mid = (left + right) // 2
            count = mid // a + mid // b - mid // lcm_ab
            if count < n:
                left = mid + 1
            else:
                right = mid

        return left % MOD