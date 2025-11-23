class Solution:
    def checkSubstringPalindrome(self, s: str) -> bool:
        n = len(s)
        for i in range(n):
            for j in range(i + 1, n + 1):
                if s[i:j] == s[i:j][::-1]:
                    return True
        return False