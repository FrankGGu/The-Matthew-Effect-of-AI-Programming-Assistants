class Solution:
    def validPalindrome(self, s: str) -> bool:
        def is_palindrome(sub_s, i, j):
            while i < j:
                if sub_s[i] != sub_s[j]:
                    return False
                i += 1
                j -= 1
            return True

        left = 0
        right = len(s) - 1

        while left < right:
            if s[left] != s[right]:
                # Try deleting s[left] or s[right]
                return is_palindrome(s, left + 1, right) or is_palindrome(s, left, right - 1)
            left += 1
            right -= 1

        return True