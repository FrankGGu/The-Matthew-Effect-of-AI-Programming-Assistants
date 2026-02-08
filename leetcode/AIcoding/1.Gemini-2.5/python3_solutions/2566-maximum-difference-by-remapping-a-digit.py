class Solution:
    def maxDiff(self, num: int) -> int:
        s_num = str(num)

        # Calculate max_val
        s_max_num_list = list(s_num)
        digit_to_replace_for_max = ''
        for digit in s_num:
            if digit != '9':
                digit_to_replace_for_max = digit
                break

        if digit_to_replace_for_max != '':
            for i in range(len(s_max_num_list)):
                if s_max_num_list[i] == digit_to_replace_for_max:
                    s_max_num_list[i] = '9'

        max_val = int("".join(s_max_num_list))

        # Calculate min_val
        s_min_num_list = list(s_num)

        # To minimize the number, we want to make the most significant digit as small as possible.
        # The smallest possible digit for the first position is '1', or '0' if the number becomes 0 itself.
        # We can always pick the first digit of the number, say 'x', and replace all occurrences of 'x' with '0'.
        # Since num >= 1, s_num[0] will never be '0'.
        # Replacing s_num[0] with '0' will either result in 0 (e.g., 111 -> 000) or a number without a leading zero (e.g., 123 -> 023 -> 23).

        digit_to_replace_for_min = s_num[0]
        replacement_digit_for_min = '0'

        for i in range(len(s_min_num_list)):
            if s_min_num_list[i] == digit_to_replace_for_min:
                s_min_num_list[i] = replacement_digit_for_min

        min_val = int("".join(s_min_num_list))

        return max_val - min_val