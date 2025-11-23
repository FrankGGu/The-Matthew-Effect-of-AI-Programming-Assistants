class Solution:
    def numberOfUniqueGoodSubsequences(self, s: str) -> int:
        has_zero = '0' in s
        has_one = '1' in s
        dp = [0] * 2
        for c in s:
            if c == '0':
                dp[0] = dp[0] + dp[1] + 1
            else:
                dp[1] = dp[0] + dp[1] + 1
        return (dp[0] + dp[1]) - (0 if has_zero and has_one else 1)