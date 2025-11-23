class Solution:
    def makeSmallestPalindrome(self, s: str) -> str:
        s = list(s)
        n = len(s)
        for i in range(n // 2):
            if s[i] != s[n - 1 - i]:
                s[i] = s[n - 1 - i] = min(s[i], s[n - 1 - i])
        return ''.join(s)