class Solution:
    def numPrimeArrangements(self, n: int) -> int:
        def is_prime(num):
            if num <= 1:
                return False
            for i in range(2, int(num**0.5) + 1):
                if num % i == 0:
                    return False
            return True

        prime_count = 0
        for i in range(1, n + 1):
            if is_prime(i):
                prime_count += 1

        non_prime_count = n - prime_count

        def factorial(num):
            res = 1
            for i in range(1, num + 1):
                res = (res * i) % (10**9 + 7)
            return res

        return (factorial(prime_count) * factorial(non_prime_count)) % (10**9 + 7)