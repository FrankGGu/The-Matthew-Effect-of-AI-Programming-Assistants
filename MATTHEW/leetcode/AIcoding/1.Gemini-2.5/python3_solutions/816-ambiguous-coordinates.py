class Solution:
    def ambiguousCoordinates(self, s: str) -> list[str]:
        def get_valid_numbers(num_str: str) -> list[str]:
            valid_nums = []
            n = len(num_str)

            # Case 1: Integer
            if num_str == "0" or (num_str[0] != '0' and num_str != ""):
                valid_nums.append(num_str)

            # Case 2: Decimal
            for i in range(1, n):
                left_part = num_str[:i]
                right_part = num_str[i:]

                # Check conditions for left_part (integer part of decimal)
                # It cannot have leading zeros unless it's just "0"
                is_left_valid = (left_part == "0" or left_part[0] != '0')

                # Check conditions for right_part (fractional part of decimal)
                # It cannot have trailing zeros
                is_right_valid = (right_part[-1] != '0')

                if is_left_valid and is_right_valid:
                    valid_nums.append(left_part + "." + right_part)

            return valid_nums

        s_digits = s[1:-1]
        n_digits = len(s_digits)
        result = []

        # Iterate through all possible split points for X and Y
        # i represents the length of the X part
        for i in range(1, n_digits):
            x_str_raw = s_digits[:i]
            y_str_raw = s_digits[i:]

            valid_xs = get_valid_numbers(x_str_raw)
            valid_ys = get_valid_numbers(y_str_raw)

            for x in valid_xs:
                for y in valid_ys:
                    result.append(f"({x}, {y})")

        return result