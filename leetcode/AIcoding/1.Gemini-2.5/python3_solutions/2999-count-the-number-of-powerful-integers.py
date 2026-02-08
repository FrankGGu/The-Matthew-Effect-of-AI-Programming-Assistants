import math

class Solution:
    def countPowerfulIntegers(self, start: int, finish: int) -> int:

        # Helper function to compute floor(num^(1/k)) using binary search
        def integer_kth_root(num: int, k: int) -> int:
            if k == 1:
                return num
            if num == 0:
                return 0
            if num == 1:
                return 1

            low = 1
            # Determine a safe upper bound for binary search
            # For k=2, x can go up to 10^9.
            # For k=3, x can go up to 10^6.
            # For k=59, x can be 2.
            # A general upper bound can be estimated using float power, then adding a small margin.
            # Python's int can handle large numbers, so `mid**k` won't overflow in terms of type.
            # The maximum possible base for any k is 10^9 (when k=2 and num=10^18).
            # So, `high` can be capped at 10^9 + 7 for safety.
            # For k >= 2, the largest possible base x is `floor(num**(1/k))`.
            # `num**(1.0/k)` can be used to get an estimate for `high`.
            # `high` should be at least 2 for bases.

            if k == 2:
                high = int(math.isqrt(num)) + 2 # isqrt is precise for squares
            else:
                # For k > 2, float power is usually accurate enough for a high bound.
                # Add 2 to be safe against precision errors.
                high = int(num**(1.0/k)) + 2

            # Ensure high is not too small (e.g., if num is small)
            high = max(high, 2) 

            ans = 1 # Smallest base is 1 (1^k = 1)
            while low <= high:
                mid = (low + high) // 2
                if mid == 0: # Base 0 is not considered for x > 0
                    low = 1
                    continue

                # Calculate mid**k. Python handles large integers automatically.
                # If mid is too large, mid**k will exceed num.
                # To prevent very large intermediate calculation when mid is very large and k is small,
                # we can check if mid exceeds a certain threshold based on num and k.
                # However, for num up to 10^18 and k up to 59, mid**k is within Python's reasonable limits.

                val = mid**k

                if val <= num:
                    ans = mid
                    low = mid + 1
                else:
                    high = mid - 1
            return ans

        # Function to count distinct powerful integers up to N (inclusive of 1)
        # A powerful integer is x^y where x > 0, y > 1.
        # This uses Mobius inversion principle.
        # The count of distinct perfect powers (x >= 2) up to N is:
        # sum_{k=2 to log2(N)} (-mu(k)) * (floor(N^(1/k)) - 1)
        # Then add 1 for the number 1 (which is 1^y for any y > 1).
        def count_perfect_powers_up_to(N: int) -> int:
            if N == 0:
                return 0

            # Max exponent y for N=10^18 is log2(10^18) approx 59.79, so up to 59.
            # We need to go up to 59, so limit_y = 60 is safe.
            limit_y = int(math.log2(N)) + 2

            # Sieve to compute Mobius function (mu)
            mobius = [0] * (limit_y + 1)
            is_prime = [True] * (limit_y + 1)
            primes = []

            is_prime[0] = is_prime[1] = False
            mobius[1] = 1 # mu(1) = 1

            for i in range(2, limit_y + 1):
                if is_prime[i]:
                    primes.append(i)
                    mobius[i] = -1 # mu(prime) = -1
                for p in primes:
                    if i * p > limit_y:
                        break
                    is_prime[i * p] = False
                    if i % p == 0:
                        mobius[i * p] = 0 # mu(n) = 0 if n has a squared prime factor
                        break
                    else:
                        mobius[i * p] = -mobius[i] # mu(p*q) = -mu(q) if p is not a factor of q

            count = 0
            # Iterate through possible exponents y from 2 up to limit_y
            for y in range(2, limit_y + 1):
                if mobius[y] == 0:
                    continue # Skip if y has a squared prime factor (mu(y)=0)

                # Calculate floor(N^(1/y))
                root_val = integer_kth_root(N, y)

                # We are counting bases x >= 2. So (root_val - 1) gives count of bases from 2 to root_val.
                # The formula uses -mu(y) for inclusion-exclusion.
                count += (-mobius[y]) * (root_val - 1)

            # Add 1 for the number 1 (1 is a powerful integer: 1^y for any y > 1)
            # The sum above counts perfect powers x >= 2.
            return count + 1

        # The problem asks for count in range [start, finish]
        # This is equivalent to count_up_to(finish) - count_up_to(start - 1)
        return count_perfect_powers_up_to(finish) - count_perfect_powers_up_to(start - 1)