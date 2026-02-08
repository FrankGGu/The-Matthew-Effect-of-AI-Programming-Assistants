class Solution:
    def longestBeautifulSubstring(self, word: str) -> int:
        vowels = "aeiou"
        max_len = 0
        current_len = 0
        vowel_idx = 0  # Represents the index of the last vowel successfully matched in the 'vowels' string

        for char in word:
            if char == vowels[vowel_idx]:
                current_len += 1
            elif vowel_idx + 1 < 5 and char == vowels[vowel_idx + 1]:
                vowel_idx += 1
                current_len += 1
            else:
                # Character is out of order or a vowel that's too far ahead/behind.
                # Reset the current sequence.
                if char == 'a':
                    # Start a new sequence with 'a'
                    current_len = 1
                    vowel_idx = 0
                else:
                    # Not 'a', so this character cannot start a valid beautiful substring.
                    # Reset to waiting for 'a'.
                    current_len = 0
                    vowel_idx = 0

            # If the current sequence has reached 'u' (vowel_idx == 4),
            # update the maximum length found so far.
            if vowel_idx == 4:
                max_len = max(max_len, current_len)

        return max_len