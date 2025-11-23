class Solution:
    def longestIdealString(self, s: str, k: int) -> int:
        dp = [0] * 26
        for c in s:
            current = ord(c) - ord('a')
            start = max(0, current - k)
            end = min(25, current + k)
            max_len = 0
            for i in range(start, end + 1):
                if dp[i] > max_len:
                    max_len = dp[i]
            dp[current] = max_len + 1
        return max(dp)