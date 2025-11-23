class Solution:
    def distinctSubseqII(self, s: str) -> int:
        MOD = 10**9 + 7
        dp = [0] * 26
        total = 0
        for c in s:
            idx = ord(c) - ord('a')
            prev = dp[idx]
            dp[idx] = (total + 1) % MOD
            total = (total + dp[idx] - prev) % MOD
        return total