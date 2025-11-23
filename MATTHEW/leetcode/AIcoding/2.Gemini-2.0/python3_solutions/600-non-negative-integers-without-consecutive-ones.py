class Solution:
    def findIntegers(self, n: int) -> int:
        fib = [1, 2]
        while fib[-1] <= n:
            fib.append(fib[-1] + fib[-2])

        fib.pop()

        ans = 0
        prev = 0
        for i in range(len(bin(n)) - 2):
            if (n >> (len(bin(n)) - 3 - i)) & 1:
                ans += fib[len(fib) - 1 - i]
                if prev == 1:
                    return ans
                prev = 1
            else:
                prev = 0
        return ans + 1