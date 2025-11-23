class Solution:
    def stringCount(self, n: int) -> int:
        MOD = 10**9 + 7

        total = pow(26, n, MOD)
        no_l = pow(25, n, MOD)
        no_e = pow(25, n, MOD)
        no_t = pow(25, n, MOD)
        no_le = pow(24, n, MOD)
        no_lt = pow(24, n, MOD)
        no_et = pow(24, n, MOD)
        no_let = pow(23, n, MOD)

        result = (total - no_l - no_e - no_t + no_le + no_lt + no_et - no_let) % MOD
        return result