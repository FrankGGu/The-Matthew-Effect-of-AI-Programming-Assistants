class Solution:
    def longestIdealString(self, s: str, k: int) -> int:
        dp = [0] * 26
        for c in s:
            idx = ord(c) - ord('a')
            curr = 1
            for i in range(26):
                if abs(i - idx) <= k:
                    curr = max(curr, dp[i] + 1)
            dp[idx] = curr
        return max(dp)