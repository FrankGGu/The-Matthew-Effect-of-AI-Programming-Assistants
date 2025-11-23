from math import factorial

class Solution:
    def numberOfSequence(self, n: int, sick: list[int]) -> int:
        m = len(sick)
        healthy = n - m
        sick.sort()
        mod = 10**9 + 7

        def inv(x):
            return pow(x, mod - 2, mod)

        ans = factorial(healthy + 1)
        for i in range(1, healthy + 1):
            ans = (ans * inv(i)) % mod

        ans = (ans * factorial(healthy)) % mod

        for i in range(1, healthy + 1):
            ans = (ans * inv(i)) % mod

        for i in range(m):
            ans = (ans * factorial(1)) % mod

        ans = (ans * factorial(m)) % mod

        for i in range(m):
            if i == 0:
                ans = (ans * pow(1, sick[i], mod)) % mod
            else:
                ans = (ans * pow(1, sick[i] - sick[i-1] - 1, mod)) % mod

        ans = (ans * pow(1, n - sick[-1] - 1, mod)) % mod if m > 0 and n - sick[-1] - 1 > 0 else ans

        return ans