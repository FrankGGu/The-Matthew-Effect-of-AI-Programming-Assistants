class Solution:
    def sumOfPowers(self, n: int) -> int:
        def prime_factors(x):
            i = 2
            factors = []
            while i * i <= x:
                if x % i == 0:
                    factors.append(i)
                    x //= i
                else:
                    i += 1
            if x > 1:
                factors.append(x)
            return factors

        def replace_with_sum(x):
            factors = prime_factors(x)
            return sum(factors)

        while n >= 10:
            n = replace_with_sum(n)
        return n