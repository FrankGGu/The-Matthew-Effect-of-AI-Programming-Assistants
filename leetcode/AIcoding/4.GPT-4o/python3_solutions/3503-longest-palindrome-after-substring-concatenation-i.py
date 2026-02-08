class Solution:
    def longestPalindrome(self, s: str) -> str:
        def is_palindrome(sub: str) -> bool:
            return sub == sub[::-1]

        max_len = 0
        longest_pal = ""
        n = len(s)

        for i in range(n):
            for j in range(i, n):
                if is_palindrome(s[i:j + 1]):
                    if (j - i + 1) > max_len:
                        max_len = j - i + 1
                        longest_pal = s[i:j + 1]

        return longest_pal