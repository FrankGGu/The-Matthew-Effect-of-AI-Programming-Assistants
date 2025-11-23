class Solution:
    def longestContinuousSubstring(self, s: str) -> int:
        if not s:
            return 0

        max_len = 1
        curr_len = 1

        for i in range(1, len(s)):
            if ord(s[i]) == ord(s[i-1]) + 1:
                curr_len += 1
            else:
                max_len = max(max_len, curr_len)
                curr_len = 1

        max_len = max(max_len, curr_len)

        return max_len