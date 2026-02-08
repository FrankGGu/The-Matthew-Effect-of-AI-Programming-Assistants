from fractions import Fraction

class Solution:
    def simplifiedFractions(self, n: int) -> list[str]:
        result = []
        for denominator in range(2, n + 1):
            for numerator in range(1, denominator):
                fraction = Fraction(numerator, denominator)
                if fraction.numerator == numerator and fraction.denominator == denominator:
                    result.append(f"{numerator}/{denominator}")
        return result