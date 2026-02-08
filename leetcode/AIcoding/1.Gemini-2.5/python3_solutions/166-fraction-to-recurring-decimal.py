class Solution:
    def fractionToDecimal(self, numerator: int, denominator: int) -> str:
        if numerator == 0:
            return "0"

        result = []

        if (numerator < 0) != (denominator < 0):
            result.append("-")

        num = abs(numerator)
        den = abs(denominator)

        result.append(str(num // den))

        remainder = num % den

        if remainder == 0:
            return "".join(result)

        result.append(".")

        remainder_map = {} 

        while remainder != 0:
            if remainder in remainder_map:
                insert_idx = remainder_map[remainder]
                result.insert(insert_idx, "(")
                result.append(")")
                return "".join(result)

            remainder_map[remainder] = len(result) 

            remainder *= 10
            result.append(str(remainder // den))
            remainder %= den

        return "".join(result)