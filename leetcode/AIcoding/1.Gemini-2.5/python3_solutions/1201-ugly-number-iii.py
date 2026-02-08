import math

class Solution:
    def nthUglyNumber(self, n: int, a: int, b: int, c: int) -> int:

        def gcd(x, y):
            return math.gcd(x, y)

        def lcm(x, y):
            if x == 0 or y == 0:
                return 0
            return (x * y) // gcd(x, y)

        lcm_ab = lcm(a, b)
        lcm_ac = lcm(a, c)
        lcm_bc = lcm(b, c)
        lcm_abc = lcm(lcm_ab, c)

        def count_ugly_numbers_up_to(num):
            count = 0
            count += num // a
            count += num // b
            count += num // c
            count -= num // lcm_ab
            count -= num // lcm_ac
            count -= num // lcm_bc
            count += num // lcm_abc
            return count

        low = 1
        high = 2 * 10**18 
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if count_ugly_numbers_up_to(mid) >= n:
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans