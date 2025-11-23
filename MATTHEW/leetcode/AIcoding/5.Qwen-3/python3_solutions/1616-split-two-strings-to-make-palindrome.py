class Solution:
    def isPalindrome(self, s: str) -> bool:
        return s == s[::-1]

    def check(self, a: str, b: str) -> bool:
        i, j = 0, len(a) - 1
        while i < j:
            if a[i] != b[j]:
                return self.isPalindrome(a[i:j+1]) or self.isPalindrome(b[i:j+1])
            i += 1
            j -= 1
        return True

    def checkPalindromeFormation(self, a: str, b: str) -> bool:
        return self.check(a, b) or self.check(b, a)