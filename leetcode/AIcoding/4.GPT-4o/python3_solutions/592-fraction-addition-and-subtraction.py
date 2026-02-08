from fractions import Fraction

class Solution:
    def fractionAddition(self, expression: str) -> str:
        total = Fraction(0)
        i = 0
        n = len(expression)

        while i < n:
            sign = 1
            if expression[i] == '+':
                i += 1
            elif expression[i] == '-':
                sign = -1
                i += 1

            j = i
            while j < n and expression[j] != '+' and expression[j] != '-':
                j += 1

            num, denom = map(int, expression[i:j].split('/'))
            total += sign * Fraction(num, denom)
            i = j

        return f"{total.numerator}/{total.denominator}"