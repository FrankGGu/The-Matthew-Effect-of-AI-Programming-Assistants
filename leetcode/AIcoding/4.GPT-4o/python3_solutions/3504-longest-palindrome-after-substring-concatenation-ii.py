class Solution:
    def longestPalindrome(self, s: str) -> str:
        def is_palindrome(sub: str) -> bool:
            return sub == sub[::-1]

        max_length = 0
        longest_palindrome = ""

        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                if is_palindrome(s[i:j]):
                    length = j - i
                    if length > max_length:
                        max_length = length
                        longest_palindrome = s[i:j]

        return longest_palindrome