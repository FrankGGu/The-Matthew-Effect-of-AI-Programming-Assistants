class Solution:
    def checkPalindrome(self, s, left, right):
        while left < right:
            if s[left] != s[right]:
                return False
            left += 1
            right -= 1
        return True

    def checkConcatenation(self, a, b):
        n = len(a)
        left, right = 0, n - 1
        while left < right and a[left] == b[right]:
            left += 1
            right -= 1
        return self.checkPalindrome(a, left, right) or self.checkPalindrome(b, left, right)

    def checkPalindromeFormation(self, a: str, b: str) -> bool:
        return self.checkConcatenation(a, b) or self.checkConcatenation(b, a)