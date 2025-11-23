class Solution:
    def fractionToDecimal(self, numerator: int, denominator: int) -> str:
        if numerator == 0:
            return "0"

        negative = (numerator < 0) ^ (denominator < 0)
        numerator, denominator = abs(numerator), abs(denominator)

        integer_part = str(numerator // denominator)
        remainder = numerator % denominator

        if remainder == 0:
            return "-" + integer_part if negative else integer_part

        decimal_part = []
        remainder_map = {}

        while remainder != 0:
            if remainder in remainder_map:
                decimal_part.insert(remainder_map[remainder], '(')
                decimal_part.append(')')
                break

            remainder_map[remainder] = len(decimal_part)
            remainder *= 10
            decimal_part.append(str(remainder // denominator))
            remainder %= denominator

        return ("-" if negative else "") + integer_part + "." + ''.join(decimal_part)