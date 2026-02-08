class Solution:
    def minNonZeroProduct(self, p: int) -> int:
        MOD = 10**9 + 7
        max_num = (1 << p) - 1
        pairs = max_num // 2
        power = pow(max_num - 1, pairs, MOD)
        return (max_num % MOD) * power % MOD