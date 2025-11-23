class Solution:
    def nthMagicalNumber(self, n: int, a: int, b: int) -> int:
        import math
        MOD = 10**9 + 7
        def lcm(x, y):
            return x * y // math.gcd(x, y)
        low = 1
        high = n * min(a, b)
        while low < high:
            mid = (low + high) // 2
            count = mid // a + mid // b - mid // lcm(a, b)
            if count < n:
                low = mid + 1
            else:
                high = mid
        return low % MOD