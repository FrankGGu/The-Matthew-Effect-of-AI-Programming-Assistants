class Solution:
    def maximumNumberOfPrimes(self, n: int) -> int:
        def is_prime(num):
            if num < 2:
                return False
            for i in range(2, int(num**0.5) + 1):
                if num % i == 0:
                    return False
            return True

        def count_primes_up_to(n):
            count = 0
            for i in range(2, n + 1):
                if is_prime(i):
                    count += 1
            return count

        if n < 2:
            return 0
        elif n == 2:
            return 1
        else:
            return count_primes_up_to(n)