class Solution:
    def largestInteger(self, num: int) -> int:
        s_num = str(num)

        even_digits = []
        odd_digits = []

        # Store the parity of each digit's original position
        # True for even, False for odd
        parity_at_position = [] 

        for char_digit in s_num:
            digit = int(char_digit)
            if digit % 2 == 0:
                even_digits.append(digit)
                parity_at_position.append(True)
            else:
                odd_digits.append(digit)
                parity_at_position.append(False)

        even_digits.sort(reverse=True)
        odd_digits.sort(reverse=True)

        result_digits = []
        even_idx = 0
        odd_idx = 0

        for is_even_pos in parity_at_position:
            if is_even_pos:
                result_digits.append(str(even_digits[even_idx]))
                even_idx += 1
            else:
                result_digits.append(str(odd_digits[odd_idx]))
                odd_idx += 1

        return int("".join(result_digits))