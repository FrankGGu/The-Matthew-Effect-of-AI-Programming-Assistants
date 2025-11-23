class Solution:
    def maximizeDistinctPrimes(self, n: int) -> int:
        if n < 2:
            return 0

        spf = list(range(n + 1))
        for i in range(2, int(n**0.5) + 1):
            if spf[i] == i:
                for multiple in range(i * i, n + 1, i):
                    if spf[multiple] == multiple:
                        spf[multiple] = i

        def get_distinct_prime_factors(num):
            factors = set()
            if num <= 1:
                return factors

            temp = num
            while temp > 1:
                factor = spf[temp]
                factors.add(factor)
                while temp > 1 and temp % factor == 0:
                    temp //= factor
            return factors

        max_distinct_primes = 0

        for a in range(1, n):
            b = n - a

            factors_a = get_distinct_prime_factors(a)
            factors_b = get_distinct_prime_factors(b)

            combined_factors = factors_a.union(factors_b)
            max_distinct_primes = max(max_distinct_primes, len(combined_factors))

        return max_distinct_primes