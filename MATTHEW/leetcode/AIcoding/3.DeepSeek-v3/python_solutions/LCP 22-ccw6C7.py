class Solution:
    def paintingPlan(self, n: int, k: int) -> int:
        if k == 0 or k == n * n:
            return 1

        res = 0
        for i in range(n + 1):
            for j in range(n + 1):
                if (i * n) + (j * n) - (i * j) == k:
                    res += self.comb(n, i) * self.comb(n, j)
        return res

    def comb(self, n, m):
        if m == 0:
            return 1
        res = 1
        for i in range(m):
            res = res * (n - i) // (i + 1)
        return res