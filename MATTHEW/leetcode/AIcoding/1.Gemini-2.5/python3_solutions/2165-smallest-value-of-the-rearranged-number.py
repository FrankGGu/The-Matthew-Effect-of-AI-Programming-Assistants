class Solution:
    def smallestNumber(self, num: int) -> int:
        if num == 0:
            return 0

        s = str(num)

        if num > 0:
            digits = sorted(list(s))
            # Handle leading zeros for positive numbers
            if digits[0] == '0':
                # Find the first non-zero digit to swap with the first zero
                for i in range(1, len(digits)):
                    if digits[i] != '0':
                        digits[0], digits[i] = digits[i], digits[0]
                        break
            return int("".join(digits))
        else: # num < 0
            # For negative numbers, to get the smallest value,
            # we need to form the largest absolute value.
            # This means sorting the digits (excluding the sign) in descending order.
            digits = sorted(list(s[1:]), reverse=True)
            return int("-" + "".join(digits))