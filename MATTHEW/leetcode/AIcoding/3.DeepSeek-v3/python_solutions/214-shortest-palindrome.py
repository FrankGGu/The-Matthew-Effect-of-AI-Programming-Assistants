class Solution:
    def shortestPalindrome(self, s: str) -> str:
        n = len(s)
        rev = s[::-1]
        for i in range(n):
            if s.startswith(rev[i:]):
                return rev[:i] + s
        return rev + s