class Solution:
    def consecutiveNumbersSum(self, N: int) -> int:
        # The problem can be rephrased: find the number of ways to write N
        # as a sum of k consecutive positive integers starting from x.
        # N = x + (x+1) + ... + (x+k-1)
        # N = k*x + k*(k-1)/2
        # 2N = 2kx + k(k-1)
        # 2N = k * (2x + k - 1)

        # Let A = k and B = 2x + k - 1.
        # We have A * B = 2N.
        # Also, B - A = (2x + k - 1) - k = 2x - 1.
        # Since x is a positive integer (x >= 1), 2x - 1 must be a positive odd integer.
        # This implies that A and B must have different parities (one even, one odd).
        # Also, B must be strictly greater than A (B - A > 0).

        # It is a known property that the number of ways to write N as a sum of consecutive
        # positive integers is equal to the number of odd divisors of N.

        # Step 1: Remove all factors of 2 from N to get its odd part.
        # This effectively transforms N into its largest odd divisor.
        while N % 2 == 0:
            N //= 2

        # Now N is an odd number. We need to count its divisors.
        # Since N is odd, all its divisors must also be odd.

        count_divisors = 0
        d = 1
        # Iterate through possible divisors up to sqrt(N)
        while d * d <= N:
            if N % d == 0:
                # d is a divisor
                # If d*d == N, then d is the only divisor in this pair (d, N/d)
                if d * d == N:
                    count_divisors += 1
                # If d*d != N, then d and N/d are two distinct divisors
                else:
                    count_divisors += 2
            # Since N is odd, all its divisors must be odd.
            # We only need to check odd numbers for d.
            d += 2 

        return count_divisors