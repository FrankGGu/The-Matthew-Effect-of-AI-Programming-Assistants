import math

class Solution:
    def numPrimeArrangements(self, n: int) -> int:
        def is_prime(num):
            if num <= 1:
                return False
            for i in range(2, int(math.sqrt(num)) + 1):
                if num % i == 0:
                    return False
            return True

        prime_count = 0
        for i in range(1, n + 1):
            if is_prime(i):
                prime_count += 1

        return (math.factorial(prime_count) * math.factorial(n - prime_count)) % (10**9 + 7)