class Solution:
    def countSubstrings(self, s: str) -> int:
        n = len(s)
        count = 0

        def expand_and_count(left: int, right: int) -> int:
            palindromes_from_center = 0
            while left >= 0 and right < n and s[left] == s[right]:
                palindromes_from_center += 1
                left -= 1
                right += 1
            return palindromes_from_center

        for i in range(2 * n - 1):
            left = i // 2
            right = left + (i % 2)
            count += expand_and_count(left, right)

        return count