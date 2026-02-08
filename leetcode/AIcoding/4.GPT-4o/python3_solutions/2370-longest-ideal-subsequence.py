class Solution:
    def longestIdealString(self, s: str, k: int) -> int:
        dp = [0] * 128
        for char in s:
            index = ord(char)
            max_len = 0
            for j in range(max(0, index - k), min(128, index + k + 1)):
                max_len = max(max_len, dp[j])
            dp[index] = max(dp[index], max_len + 1)
        return max(dp)