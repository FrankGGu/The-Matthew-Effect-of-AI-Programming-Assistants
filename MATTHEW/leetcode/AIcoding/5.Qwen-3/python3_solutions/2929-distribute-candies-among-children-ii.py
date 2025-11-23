class Solution:
    def distributeCandies(self, n: int, limit: int) -> int:
        def comb(k):
            return k * (k - 1) // 2 if k >= 2 else 0

        def f(x):
            return max(0, x - 2 * limit)

        res = 0
        for i in range(n + 1):
            a = f(i)
            b = f(n - i)
            res += comb(a + 1) * comb(b + 1)
        return res