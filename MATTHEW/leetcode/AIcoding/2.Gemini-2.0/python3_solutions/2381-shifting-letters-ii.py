class Solution:
    def shiftingLetters(self, s: str, shifts: List[List[int]]) -> str:
        n = len(s)
        prefix_sum = [0] * (n + 1)
        for start, end, direction in shifts:
            if direction == 1:
                prefix_sum[start] += 1
                prefix_sum[end + 1] -= 1
            else:
                prefix_sum[start] -= 1
                prefix_sum[end + 1] += 1

        result = ""
        current_shift = 0
        for i in range(n):
            current_shift += prefix_sum[i]
            shift_val = current_shift % 26

            char_val = ord(s[i]) - ord('a')
            new_char_val = (char_val + shift_val) % 26

            result += chr(new_char_val + ord('a'))

        return result