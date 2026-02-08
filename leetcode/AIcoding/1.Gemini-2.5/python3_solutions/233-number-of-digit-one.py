class Solution:
    def countDigitOne(self, n: int) -> int:
        if n < 0:
            return 0

        count = 0
        m = 1  # Represents the current place value (1, 10, 100, ...)

        while m <= n:
            # a: The part of n to the left of and including the current digit
            #    e.g., if n = 12345 and m = 100, then a = 123
            a = n // m

            # b: The part of n to the right of the current digit
            #    e.g., if n = 12345 and m = 100, then b = 45
            b = n % m

            # current_digit: The digit at the m-th place
            #    e.g., if n = 12345 and m = 100, then current_digit = 3
            current_digit = a % 10

            # leading_part: The number formed by digits strictly to the left of the current digit
            #    e.g., if n = 12345 and m = 100, then leading_part = 12
            leading_part = a // 10

            if current_digit == 0:
                # If the current digit is 0, the number of 1s at this place
                # is determined by the full blocks of 'm' numbers.
                # Each 'leading_part' block contributes 'm' ones.
                # E.g., for n=20, m=1 (units place), leading_part=2, current_digit=0.
                # Numbers 1, 11 have 1 at units place. Count = 2 * 1 = 2.
                count += leading_part * m
            elif current_digit == 1:
                # If the current digit is 1, the number of 1s at this place
                # includes full blocks from 'leading_part', plus the current partial block.
                # The current partial block contributes 'b + 1' ones (from X10...X1b).
                # E.g., for n=13, m=10 (tens place), leading_part=0, current_digit=1, b=3.
                # Numbers 10, 11, 12, 13 have 1 at tens place. Count = 0*10 + 3 + 1 = 4.
                count += leading_part * m + b + 1
            else: # current_digit > 1
                # If the current digit is greater than 1, all numbers with '1'
                # at this place up to 'n' are fully covered.
                # This means (leading_part + 1) full blocks of 'm' numbers contribute 'm' ones each.
                # E.g., for n=13, m=1 (units place), leading_part=1, current_digit=3.
                # Numbers 1, 11 have 1 at units place. Count = (1+1)*1 = 2.
                count += (leading_part + 1) * m

            m *= 10

        return count