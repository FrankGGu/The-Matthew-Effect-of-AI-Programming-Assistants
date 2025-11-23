class Solution:
    def getLucky(self, s: str, k: int) -> int:
        initial_digit_string_parts = []
        for char_code in s:
            position = ord(char_code) - ord('a') + 1
            initial_digit_string_parts.append(str(position))

        current_num_str = "".join(initial_digit_string_parts)

        for _ in range(k):
            current_sum = 0
            for digit_char in current_num_str:
                current_sum += int(digit_char)

            current_num_str = str(current_sum)

        return int(current_num_str)