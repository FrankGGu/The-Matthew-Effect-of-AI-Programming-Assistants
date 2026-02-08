class Solution:
    def findIntegers(self, n: int) -> int:
        fib = [0] * 32
        fib[0], fib[1] = 1, 2

        for i in range(2, 32):
            fib[i] = fib[i - 1] + fib[i - 2]

        res, prev_bit = 0, 0

        for i in range(30, -1, -1):
            if n & (1 << i):
                res += fib[i]
                if prev_bit:
                    return res
                prev_bit = 1
            else:
                prev_bit = 0

        return res + 1