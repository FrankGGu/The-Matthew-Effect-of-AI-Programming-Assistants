class Solution:
    def fractionToDecimal(self, numerator: int, denominator: int) -> str:
        if numerator == 0:
            return "0"

        res = []
        if (numerator < 0) ^ (denominator < 0):
            res.append("-")

        numerator, denominator = abs(numerator), abs(denominator)
        res.append(str(numerator // denominator))
        remainder = numerator % denominator
        if remainder == 0:
            return "".join(res)

        res.append(".")
        seen = {}
        while remainder != 0:
            if remainder in seen:
                res.insert(seen[remainder], "(")
                res.append(")")
                break
            seen[remainder] = len(res)
            remainder *= 10
            res.append(str(remainder // denominator))
            remainder = remainder % denominator

        return "".join(res)