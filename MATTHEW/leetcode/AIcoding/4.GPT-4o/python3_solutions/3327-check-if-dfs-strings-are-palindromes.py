class Solution:
    def checkPalindromeFormation(self, a: str, b: str) -> bool:
        def is_palindrome(s, left, right):
            while left < right:
                if s[left] != s[right]:
                    return False
                left += 1
                right -= 1
            return True

        n = len(a)
        return is_palindrome(a, 0, n - 1) or is_palindrome(b, 0, n - 1) or is_palindrome(a, 0, n // 2 - 1) and is_palindrome(b, n - 1 - (n // 2), n - 1) or is_palindrome(b, 0, n // 2 - 1) and is_palindrome(a, n - 1 - (n // 2), n - 1)