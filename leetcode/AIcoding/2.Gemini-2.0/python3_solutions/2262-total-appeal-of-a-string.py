class Solution:
    def totalAppealSum(self, s: str) -> int:
        n = len(s)
        dp = [0] * n
        last = {}
        res = 0
        for i in range(n):
            c = s[i]
            if c in last:
                dp[i] = dp[i-1] + (i - last[c])
            else:
                dp[i] = dp[i-1] + (i + 1)
            last[c] = i
            res += dp[i]
        return res