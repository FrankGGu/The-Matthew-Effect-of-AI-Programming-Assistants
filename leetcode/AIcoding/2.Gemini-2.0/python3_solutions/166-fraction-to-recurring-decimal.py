class Solution:
    def fractionToDecimal(self, numerator: int, denominator: int) -> str:
        if numerator == 0:
            return "0"

        sign = "-" if (numerator < 0) ^ (denominator < 0) else ""
        numerator = abs(numerator)
        denominator = abs(denominator)

        integer_part = numerator // denominator
        remainder = numerator % denominator

        if remainder == 0:
            return sign + str(integer_part)

        decimal_part = ""
        remainders = {}
        index = 0
        while remainder != 0 and remainder not in remainders:
            remainders[remainder] = index
            remainder *= 10
            decimal_part += str(remainder // denominator)
            remainder %= denominator
            index += 1

        if remainder == 0:
            return sign + str(integer_part) + "." + decimal_part
        else:
            recurring_index = remainders[remainder]
            return sign + str(integer_part) + "." + decimal_part[:recurring_index] + "(" + decimal_part[recurring_index:] + ")"