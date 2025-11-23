class Solution:
    def findIntegers(self, n: int) -> int:
        fib = [0] * 32
        fib[0] = 1
        fib[1] = 2
        for i in range(2, 32):
            fib[i] = fib[i-1] + fib[i-2]

        s = bin(n)[2:]
        L = len(s)

        count = 0
        last_one = False

        for i in range(L - 1, -1, -1):
            if s[L - 1 - i] == '1':
                count += fib[i]

                if last_one:
                    break

                last_one = True
            else:
                last_one = False
        else:
            count += 1

        return count