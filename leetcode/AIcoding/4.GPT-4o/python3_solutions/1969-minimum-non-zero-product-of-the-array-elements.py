class Solution:
    def minNonZeroProduct(self, p: int) -> int:
        if p == 1:
            return 1
        mod = 10**9 + 7
        max_num = (1 << p) - 1
        return (max_num * pow(max_num - 1, (1 << (p - 1)) - 1, mod)) % mod