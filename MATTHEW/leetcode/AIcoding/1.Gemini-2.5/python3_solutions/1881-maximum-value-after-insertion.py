class Solution:
    def maxValue(self, n: str, x: int) -> str:
        x_char = str(x)
        n_list = list(n)

        if n[0] != '-':  # n is a positive number
            # To maximize a positive number, insert x at the first position
            # where x is greater than the current digit.
            for i in range(len(n_list)):
                if x_char > n_list[i]:
                    n_list.insert(i, x_char)
                    return "".join(n_list)
            # If x is smaller than or equal to all digits, append it to make the number largest.
            n_list.append(x_char)
            return "".join(n_list)
        else:  # n is a negative number
            # To maximize a negative number (make it closest to zero),
            # we need to make its absolute value as small as possible.
            # This means inserting x at the first position (after the '-')
            # where x is smaller than the current digit.
            for i in range(1, len(n_list)):  # Start from index 1 to skip the '-' sign
                if x_char < n_list[i]:
                    n_list.insert(i, x_char)
                    return "".join(n_list)
            # If x is greater than or equal to all digits (after '-'), append it.
            # This makes the absolute value larger, thus the negative number smaller (more negative).
            # This is correct because if x is greater than or equal to all digits,
            # inserting it anywhere else would make the absolute value even smaller,
            # resulting in a number further from zero (more negative).
            n_list.append(x_char)
            return "".join(n_list)