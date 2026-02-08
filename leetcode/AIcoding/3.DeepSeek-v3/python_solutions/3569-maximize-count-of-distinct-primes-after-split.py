class Solution:
    def distinctPrimeFactors(self, nums: List[int]) -> int:
        primes = set()

        def get_prime_factors(n):
            factors = set()
            if n == 1:
                return factors
            i = 2
            while i * i <= n:
                if n % i == 0:
                    factors.add(i)
                    while n % i == 0:
                        n = n // i
                i += 1
            if n > 1:
                factors.add(n)
            return factors

        for num in nums:
            primes.update(get_prime_factors(num))

        return len(primes)