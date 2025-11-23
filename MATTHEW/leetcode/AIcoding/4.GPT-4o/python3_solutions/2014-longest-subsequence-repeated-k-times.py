class Solution:
    def longestSubsequence(self, s: str, k: int) -> str:
        n = len(s)
        dp = [""] * (k + 1)
        for i in range(n):
            for j in range(k, 0, -1):
                if s[i] == '1':
                    dp[j] = dp[j - 1] + '1'
                dp[j] = max(dp[j], dp[j] + '0', key=len)
        return dp[k]