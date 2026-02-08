class Solution:
    def minNonZeroProduct(self, p: int) -> int:
        mod = 10**9 + 7
        max_val = (1 << p) - 1
        count = 1 << (p - 1)
        result = pow(max_val - 1, count, mod) * max_val % mod
        return result