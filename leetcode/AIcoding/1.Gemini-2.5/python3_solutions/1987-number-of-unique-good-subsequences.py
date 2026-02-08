class Solution:
    def numberOfUniqueGoodSubsequences(self, s: str) -> int:
        MOD = 10**9 + 7

        # dp0: number of unique subsequences that start with '1' and end with '0'.
        dp0 = 0
        # dp1: number of unique subsequences that start with '1' and end with '1'.
        dp1 = 0

        for char_s in s:
            if char_s == '0':
                # When '0' is encountered, we can form new subsequences ending in '0'.
                # These are formed by appending '0' to:
                # 1. Existing subsequences that start with '1' and end with '0' (dp0).
                # 2. Existing subsequences that start with '1' and end with '1' (dp1).
                # All these new subsequences will start with '1' and end with '0'.
                dp0 = (dp0 + dp1) % MOD
            else: # char_s == '1'
                # When '1' is encountered, we can form new subsequences ending in '1'.
                # These are formed by appending '1' to:
                # 1. Existing subsequences that start with '1' and end with '0' (dp0).
                # 2. Existing subsequences that start with '1' and end with '1' (dp1).
                # 3. The current '1' itself forms a new good subsequence ("1").
                # All these new subsequences will start with '1' and end with '1'.
                dp1 = (dp0 + dp1 + 1) % MOD

        # The total number of unique good subsequences is dp1, as they must end with '1'.
        return dp1