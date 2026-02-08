import math

class Solution:
    def isThree(self, n: int) -> bool:
        if n < 4:
            return False

        k = int(math.sqrt(n))

        if k * k != n:
            return False

        # Now n is a perfect square of k.
        # Check if k is a prime number.
        # A prime number has exactly two divisors: 1 and itself.
        # If k has more than two divisors (i.e., it's composite or 1),
        # then n (k*k) will have more than three divisors.
        # If k is prime, n (k*k) will have exactly three divisors: 1, k, n.

        if k <= 1: # 1 is not prime
            return False

        for i in range(2, int(math.sqrt(k)) + 1):
            if k % i == 0:
                return False # k is not prime

        return True # k is prime