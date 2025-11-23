class Solution:
    def countSpecialSubsequences(self, s: str) -> int:
        MOD = 10**9 + 7

        # dp0: number of subsequences consisting of only '0's
        # dp1: number of subsequences consisting of '0's followed by '1's
        # dp2: number of subsequences consisting of '0's followed by '1's followed by '2's
        dp0, dp1, dp2 = 0, 0, 0

        for char in s:
            if char == '0':
                # A new '0' can either:
                # 1. Start a new subsequence (the '0' itself). (+1)
                # 2. Extend any existing '0' subsequence. (+dp0)
                # 3. Be chosen not to be part of an existing '0' subsequence (keeping previous dp0 count). (+dp0)
                # So, dp0_new = dp0_old * 2 + 1
                dp0 = (2 * dp0 + 1) % MOD
            elif char == '1':
                # A new '1' can either:
                # 1. Extend any existing '0' subsequence to form a '01' subsequence. (+dp0)
                # 2. Extend any existing '01' subsequence. (+dp1)
                # 3. Be chosen not to be part of an existing '01' subsequence (keeping previous dp1 count). (+dp1)
                # So, dp1_new = dp1_old * 2 + dp0_old
                dp1 = (2 * dp1 + dp0) % MOD
            elif char == '2':
                # A new '2' can either:
                # 1. Extend any existing '01' subsequence to form a '012' subsequence. (+dp1)
                # 2. Extend any existing '012' subsequence. (+dp2)
                # 3. Be chosen not to be part of an existing '012' subsequence (keeping previous dp2 count). (+dp2)
                # So, dp2_new = dp2_old * 2 + dp1_old
                dp2 = (2 * dp2 + dp1) % MOD

        return dp2