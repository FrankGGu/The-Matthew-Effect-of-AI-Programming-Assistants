class Solution:
    def baseNeg2(self, n: int) -> str:
        if n == 0:
            return "0"

        res = []
        while n != 0:
            remainder = n % -2

            # Adjust remainder and quotient if remainder is negative
            # In base -2, digits must be 0 or 1.
            # Python's % operator returns a remainder with the same sign as the divisor.
            # So, n % -2 can be 0 or -1. We need it to be 0 or 1.
            if remainder < 0:
                remainder += 2  # Make remainder 1 instead of -1
                n = n // -2 + 1 # Adjust quotient accordingly
            else:
                n = n // -2

            res.append(str(remainder))

        return "".join(res[::-1])