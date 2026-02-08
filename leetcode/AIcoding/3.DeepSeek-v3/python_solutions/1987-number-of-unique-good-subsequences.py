class Solution:
    def numberOfUniqueGoodSubsequences(self, binary: str) -> int:
        MOD = 10**9 + 7
        dp0 = 0  # number of unique subsequences ending with '0'
        dp1 = 0  # number of unique subsequences ending with '1'
        has_zero = False

        for c in binary:
            if c == '0':
                dp0 = (dp0 + dp1 + 1) % MOD
                has_zero = True
            else:
                dp1 = (dp0 + dp1 + 1) % MOD

        total = (dp0 + dp1) % MOD
        if has_zero:
            total = (total + 1) % MOD  # add the subsequence "0"

        return total