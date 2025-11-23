import math

class Solution:
    def nthMagicalNumber(self, n: int, a: int, b: int) -> int:

        common_divisor = math.gcd(a, b)
        least_common_multiple = (a * b) // common_divisor

        def count_magical(x: int) -> int:
            return (x // a) + (x // b) - (x // least_common_multiple)

        low = 1
        high = n * max(a, b)

        ans = high

        while low <= high:
            mid = low + (high - low) // 2

            if count_magical(mid) >= n:
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans