class Solution:
    def checkPalindromeFormation(self, a: str, b: str) -> bool:
        def is_palindrome_range(s, left, right):
            while left < right:
                if s[left] != s[right]:
                    return False
                left += 1
                right -= 1
            return True

        n = len(a)
        return (is_palindrome_range(a, 0, n - 1) or is_palindrome_range(b, 0, n - 1) or 
                is_palindrome_range(a, 0, n - 2) and is_palindrome_range(b, 1, n - 1) or 
                is_palindrome_range(b, 0, n - 2) and is_palindrome_range(a, 1, n - 1))