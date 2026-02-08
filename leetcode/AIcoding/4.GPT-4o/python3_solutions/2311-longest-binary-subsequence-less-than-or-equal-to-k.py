class Solution:
    def longestSubsequence(self, s: str, k: int) -> int:
        n = len(s)
        dp = [0] * (k + 1)

        for i in range(n):
            if s[i] == '0':
                for j in range(k, -1, -1):
                    if dp[j] < j + 1:
                        dp[j] = j + 1
            else:
                for j in range(k, 0, -1):
                    if j > 0 and dp[j - 1] < j:
                        dp[j] = max(dp[j], dp[j - 1] + 1)

        return max(dp)