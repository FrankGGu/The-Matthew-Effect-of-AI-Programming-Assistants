class Solution:
    def longestPalindrome(self, s: str) -> str:
        if not s:
            return ""

        start = 0
        max_len = 0

        def expand_around_center(left: int, right: int):
            nonlocal start, max_len
            while left >= 0 and right < len(s) and s[left] == s[right]:
                left -= 1
                right += 1

            current_len = right - left - 1
            if current_len > max_len:
                max_len = current_len
                start = left + 1

        for i in range(len(s)):
            # Odd length palindromes (center is s[i])
            expand_around_center(i, i)
            # Even length palindromes (center is s[i] and s[i+1])
            expand_around_center(i, i + 1)

        return s[start : start + max_len]