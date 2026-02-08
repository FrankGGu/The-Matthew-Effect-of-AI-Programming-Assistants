class Solution:
    def stringCount(self, n: int) -> int:
        MOD = 10**9 + 7
        # Total possible strings: 26^n
        # Subtract strings missing at least one of 'l', 't', or both 'e's
        # Using inclusion-exclusion principle
        total = pow(26, n, MOD)
        no_l = pow(25, n, MOD)
        no_t = pow(25, n, MOD)
        no_e = pow(25, n, MOD)
        no_l_no_t = pow(24, n, MOD)
        no_l_no_e = pow(24, n, MOD)
        no_t_no_e = pow(24, n, MOD)
        no_l_no_t_no_e = pow(23, n, MOD)

        # Inclusion-exclusion
        res = (total - no_l - no_t - no_e + no_l_no_t + no_l_no_e + no_t_no_e - no_l_no_t_no_e) % MOD
        return res