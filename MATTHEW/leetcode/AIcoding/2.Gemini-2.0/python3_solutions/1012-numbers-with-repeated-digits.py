class Solution:
    def numDupDigitsAtMostN(self, n: int) -> int:
        s = str(n)
        k = len(s)
        ans = 0
        def A(m, n):
            res = 1
            for i in range(m, m - n, -1):
                res *= i
            return res

        for i in range(1, k):
            ans += 9 * A(9, i - 1)

        seen = set()
        for i, c in enumerate(s):
            digit = int(c)
            for j in range(0 if i else 1, digit):
                if j not in seen:
                    ans += A(9 - len(seen), k - i - 1)

            if digit in seen:
                break
            seen.add(digit)
        else:
            if len(seen) == k:
                ans += 1

        return n - ans