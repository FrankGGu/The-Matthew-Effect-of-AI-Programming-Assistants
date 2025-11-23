class Solution:
    def longestPalindrome(self, s: str) -> int:
        n = len(s)
        max_len = 0
        for i in range(n):
            for j in range(i, n):
                substr = s[i:j+1]
                if substr == substr[::-1]:
                    max_len = max(max_len, len(substr))
        return max_len