class Solution:
    def minNonZeroProduct(self, n: int) -> int:
        mod = 10**9 + 7
        max_val = (1 << n) - 1
        if n == 1:
            return 1
        return pow(max_val, max_val - 1, mod)