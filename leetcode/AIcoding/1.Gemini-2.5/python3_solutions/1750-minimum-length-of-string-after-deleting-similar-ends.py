class Solution:
    def minimumLength(self, s: str) -> int:
        left = 0
        right = len(s) - 1

        while left < right and s[left] == s[right]:
            char_to_delete = s[left]

            while left <= right and s[left] == char_to_delete:
                left += 1

            while left <= right and s[right] == char_to_delete:
                right -= 1

        return right - left + 1