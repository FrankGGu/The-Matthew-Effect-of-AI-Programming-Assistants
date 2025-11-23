class Solution:
    def numDupDigitsIntegers(self, n: int) -> int:
        from math import factorial

        def count(n):
            s = str(n)
            m = len(s)
            res = 0
            for i in range(1, m):
                res += 9 * factorial(9) // factorial(10 - i)
            used = [False] * 10
            for i in range(m):
                d = int(s[i])
                for j in range(1 if i == 0 else 0, d):
                    if not used[j]:
                        res += factorial(10 - i - 1) // factorial(10 - m)
                if used[d]:
                    break
                used[d] = True
            return res

        return count(n)