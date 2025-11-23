class Solution:
    def getLucky(self, s: str, k: int) -> int:
        digit_str_list = []
        for char_code in s:
            digit_str_list.append(str(ord(char_code) - ord('a') + 1))

        current_num_str = "".join(digit_str_list)

        for _ in range(k):
            if len(current_num_str) == 1:
                break

            current_sum = 0
            for digit_char in current_num_str:
                current_sum += int(digit_char)

            current_num_str = str(current_sum)

        return int(current_num_str)