class Solution:
    def shiftingLetters(self, s: str, shifts: list[list[int]]) -> str:
        n = len(s)
        diff = [0] * (n + 1)

        for start, end, direction in shifts:
            if direction == 1:  # Forward shift
                diff[start] += 1
                if end + 1 < n + 1:
                    diff[end + 1] -= 1
            else:  # Backward shift
                diff[start] -= 1
                if end + 1 < n + 1:
                    diff[end + 1] += 1

        result_chars = [''] * n
        current_shift = 0
        for i in range(n):
            current_shift += diff[i]

            # Convert character to 0-indexed alphabet (0 for 'a', 1 for 'b', ...)
            original_char_idx = ord(s[i]) - ord('a')

            # Apply the total shift and ensure it wraps around correctly (0-25)
            # Python's % handles negative numbers correctly: -1 % 26 == 25
            new_char_idx = (original_char_idx + current_shift) % 26

            # Convert back to character
            result_chars[i] = chr(new_char_idx + ord('a'))

        return "".join(result_chars)