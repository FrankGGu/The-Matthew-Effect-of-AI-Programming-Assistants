class Solution:
    def deepDarkFraction(self, n: int, d: int) -> str:
        from fractions import Fraction
        fraction = Fraction(n, d).limit_denominator()
        return f"{fraction.numerator}/{fraction.denominator}"