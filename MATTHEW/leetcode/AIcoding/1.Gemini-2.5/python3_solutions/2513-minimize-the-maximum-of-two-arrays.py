import math

class Solution:
    def minimizeSet(self, uniqueCnt1: int, uniqueCnt2: int, divisor1: int, divisor2: int) -> int:
        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        def lcm(a, b):
            if a == 0 or b == 0:
                return 0
            # To prevent overflow for a*b when a, b are large,
            # use (a // gcd(a, b)) * b. Python handles large integers, so a*b is fine.
            return (a * b) // gcd(a, b)

        def check(x):
            # Count of numbers <= x that are NOT divisible by divisor1
            count_not_d1 = x - (x // divisor1)

            # Count of numbers <= x that are NOT divisible by divisor2
            count_not_d2 = x - (x // divisor2)

            # If we don't even have enough numbers for uniqueCnt1 or uniqueCnt2 individually
            # from their respective allowed pools, then x is too small.
            if count_not_d1 < uniqueCnt1 or count_not_d2 < uniqueCnt2:
                return False

            # Calculate LCM for numbers divisible by both divisors
            lcm_val = lcm(divisor1, divisor2)

            # Count of numbers <= x that are NOT divisible by divisor1 AND NOT divisible by divisor2.
            # These numbers can be used by either arr1 or arr2. This is the "common pool".
            # Using Principle of Inclusion-Exclusion:
            # Total - (Div by d1) - (Div by d2) + (Div by both d1 and d2)
            count_neither = x - (x // divisor1) - (x // divisor2) + (x // lcm_val)

            # How many numbers arr1 needs from the common pool:
            # arr1 first tries to use numbers that are divisible by divisor2 but not divisor1.
            # These numbers cannot be used by arr2, so they are exclusive to arr1.
            # Count of numbers <= x that are divisible by divisor2 but NOT divisor1:
            # (x // divisor2) - (x // lcm_val)
            arr1_needed_from_common = max(0, uniqueCnt1 - ((x // divisor2) - (x // lcm_val)))

            # How many numbers arr2 needs from the common pool:
            # arr2 first tries to use numbers that are divisible by divisor1 but not divisor2.
            # These numbers cannot be used by arr1, so they are exclusive to arr2.
            # Count of numbers <= x that are divisible by divisor1 but NOT divisor2:
            # (x // divisor1) - (x // lcm_val)
            arr2_needed_from_common = max(0, uniqueCnt2 - ((x // divisor1) - (x // lcm_val)))

            # Check if the common pool has enough numbers to satisfy the remaining needs of both arrays.
            return arr1_needed_from_common + arr2_needed_from_common <= count_neither

        # Binary search range for the minimum possible maxVal (x)
        # Lower bound: At least 1.
        low = 1
        # Upper bound: A safe upper bound.
        # In the worst case (e.g., divisor1=2, divisor2=2), x/2 numbers are available for both.
        # So x/2 >= uniqueCnt1 + uniqueCnt2 implies x >= 2 * (uniqueCnt1 + uniqueCnt2).
        # Max (uniqueCnt1 + uniqueCnt2) is 2 * 10^9. So x can be up to 4 * 10^9.
        # Using 10^10 as a generous upper bound for safety, as Python handles large integers.
        high = 10**10 

        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1  # Try to find a smaller x
            else:
                low = mid + 1   # x is too small, need a larger x

        return ans