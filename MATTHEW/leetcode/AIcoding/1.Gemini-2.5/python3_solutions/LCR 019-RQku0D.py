class Solution:
    def validPalindrome(self, s: str) -> bool:
        left = 0
        right = len(s) - 1

        while left < right:
            if s[left] != s[right]:
                return self._is_palindrome_range(s, left + 1, right) or \
                       self._is_palindrome_range(s, left, right - 1)
            left += 1
            right -= 1
        return True

    def _is_palindrome_range(self, s: str, i: int, j: int) -> bool:
        while i < j:
            if s[i] != s[j]:
                return False
            i += 1
            j -= 1
        return True