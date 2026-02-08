class Solution:
    def minimumLength(self, s: str) -> int:
        left = 0
        right = len(s) - 1

        while left < right and s[left] == s[right]:
            char_to_remove = s[left]

            # Remove all occurrences of char_to_remove from the prefix
            # as long as left pointer is within bounds and matches the character.
            while left <= right and s[left] == char_to_remove:
                left += 1

            # Remove all occurrences of char_to_remove from the suffix
            # as long as right pointer is within bounds and matches the character.
            while left <= right and s[right] == char_to_remove:
                right -= 1

        # The remaining length is right - left + 1.
        # If left has crossed right, it means the string is empty, so length is 0.
        return right - left + 1