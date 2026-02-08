class Solution:
    def maximumXorProduct(self, a: int, b: int, n: int) -> int:
        MOD = 10**9 + 7
        x = 0
        for k in range(n-1, -1, -1):
            mask = 1 << k
            a_bit = (a & mask) != 0
            b_bit = (b & mask) != 0
            if a_bit == b_bit:
                x |= mask
            else:
                if (a ^ x) < (b ^ x):
                    a |= mask
                else:
                    b |= mask
        return ((a ^ x) * (b ^ x)) % MOD