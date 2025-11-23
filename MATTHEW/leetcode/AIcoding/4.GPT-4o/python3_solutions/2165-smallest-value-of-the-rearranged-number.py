class Solution:
    def smallestNumber(self, num: int) -> str:
        if num == 0:
            return "0"

        is_negative = num < 0
        num_str = str(abs(num))
        sorted_digits = sorted(num_str)

        if is_negative:
            return '-' + ''.join(sorted_digits)[::-1]

        if sorted_digits[0] == '0':
            for i in range(1, len(sorted_digits)):
                if sorted_digits[i] != '0':
                    sorted_digits[0], sorted_digits[i] = sorted_digits[i], '0'
                    break

        return ''.join(sorted_digits)