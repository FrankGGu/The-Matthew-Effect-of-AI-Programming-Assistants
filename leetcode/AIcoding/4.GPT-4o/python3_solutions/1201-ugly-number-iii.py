class Solution:
    def nthUglyNumber(self, n: int, a: int, b: int, c: int) -> int:
        def lcm(x, y):
            from math import gcd
            return x * y // gcd(x, y)

        ab = lcm(a, b)
        ac = lcm(a, c)
        bc = lcm(b, c)
        abc = lcm(ab, c)

        def count_ugly_numbers(x):
            return x // a + x // b + x // c - x // ab - x // ac - x // bc + x // abc

        left, right = 1, 2 * 10**9
        while left < right:
            mid = (left + right) // 2
            if count_ugly_numbers(mid) < n:
                left = mid + 1
            else:
                right = mid
        return left