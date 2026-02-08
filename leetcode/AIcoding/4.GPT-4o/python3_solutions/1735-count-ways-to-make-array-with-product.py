class Solution:
    def countWays(self, nums: List[int]) -> int:
        from collections import Counter
        from functools import lru_cache

        MOD = 10**9 + 7

        @lru_cache(None)
        def prime_factors_count(n):
            factors = Counter()
            d = 2
            while d * d <= n:
                while (n % d) == 0:
                    factors[d] += 1
                    n //= d
                d += 1
            if n > 1:
                factors[n] += 1
            return factors

        total_factors = Counter()

        for num in nums:
            for prime, count in prime_factors_count(num).items():
                total_factors[prime] += count

        result = 1
        for count in total_factors.values():
            result = result * (count + 1) % MOD

        return result