class Solution:
    def shiftingLetters(self, s: str, shifts: list[int]) -> str:
        n = len(s)
        result = list(s)
        current_shift_sum = 0

        for i in range(n - 1, -1, -1):
            current_shift_sum = (current_shift_sum + shifts[i]) % 26

            char_code = ord(s[i]) - ord('a')
            new_char_code = (char_code + current_shift_sum) % 26

            result[i] = chr(ord('a') + new_char_code)

        return "".join(result)