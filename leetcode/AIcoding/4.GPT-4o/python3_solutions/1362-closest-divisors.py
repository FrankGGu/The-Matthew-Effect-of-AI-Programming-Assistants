import math

class Solution:
    def closestDivisors(self, num: int) -> List[int]:
        def find_divisors(n):
            for i in range(1, int(math.sqrt(n)) + 1):
                if n % i == 0:
                    yield (i, n // i)

        for k in (num + 1, num + 2):
            for a, b in find_divisors(k):
                return [b, a]