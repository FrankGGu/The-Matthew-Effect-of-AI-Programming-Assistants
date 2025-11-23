class Solution:
    def paintingPlan(self, n: int, m: int, k: int) -> int:
        mod = 10**9 + 7
        from math import comb

        return (comb(n, k) * comb(m, k)) % mod