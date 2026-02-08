class Solution:
    def smallestValue(self, n: int) -> int:
        def sum_prime_factors(num: int) -> int:
            sum_factors = 0
            d = 2
            while d * d <= num:
                while num % d == 0:
                    sum_factors += d
                    num //= d
                d += 1
            if num > 1:
                sum_factors += num
            return sum_factors

        while True:
            s = sum_prime_factors(n)
            if s == n:
                return n
            n = s