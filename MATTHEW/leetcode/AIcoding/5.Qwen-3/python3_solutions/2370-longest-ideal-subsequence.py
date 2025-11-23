class Solution:
    def longestIdealString(self, s: str, k: int) -> int:
        dp = [0] * 26
        for c in s:
            i = ord(c) - ord('a')
            max_len = 0
            for j in range(26):
                if abs(i - j) <= k:
                    max_len = max(max_len, dp[j])
            dp[i] = max(dp[i], max_len + 1)
        return max(dp)