class Solution:
    def numPrimeArrangements(self, n: int) -> int:
        MOD = 10**9 + 7

        is_prime = [True] * (n + 1)
        if n >= 0:
            is_prime[0] = False
        if n >= 1:
            is_prime[1] = False

        for p in range(2, int(n**0.5) + 1):
            if is_prime[p]:
                for multiple in range(p * p, n + 1, p):
                    is_prime[multiple] = False

        prime_count = 0
        for i in range(2, n + 1):
            if is_prime[i]:
                prime_count += 1

        non_prime_count = n - prime_count

        def factorial(k):
            res = 1
            for i in range(1, k + 1):
                res = (res * i) % MOD
            return res

        result = (factorial(prime_count) * factorial(non_prime_count)) % MOD
        return result