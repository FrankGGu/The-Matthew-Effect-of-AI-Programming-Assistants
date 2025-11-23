class Solution:
    def numSquares(self, n: int) -> int:
        import math
        from collections import deque

        def is_square(x):
            s = int(math.isqrt(x))
            return s * s == x

        if is_square(n):
            return 1

        for i in range(1, int(math.isqrt(n)) + 1):
            if is_square(n - i * i):
                return 2

        while n % 4 == 0:
            n //= 4

        if n % 8 != 7:
            return 3

        return 4