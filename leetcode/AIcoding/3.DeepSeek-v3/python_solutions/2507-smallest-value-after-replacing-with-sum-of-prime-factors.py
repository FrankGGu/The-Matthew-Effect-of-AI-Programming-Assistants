class Solution:
    def smallestValue(self, n: int) -> int:
        def get_prime_factors(x):
            factors = []
            if x == 1:
                return factors
            # Check for 2 separately
            while x % 2 == 0:
                factors.append(2)
                x = x // 2
            # Check for odd divisors up to sqrt(x)
            i = 3
            while i * i <= x:
                while x % i == 0:
                    factors.append(i)
                    x = x // i
                i += 2
            if x > 1:
                factors.append(x)
            return factors

        seen = set()
        current = n
        while True:
            factors = get_prime_factors(current)
            if not factors:
                return current
            next_num = sum(factors)
            if next_num == current:
                return current
            if next_num in seen:
                return next_num
            seen.add(current)
            current = next_num