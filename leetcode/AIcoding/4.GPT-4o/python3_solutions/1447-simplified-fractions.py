from math import gcd

class Solution:
    def simplifiedFractions(self, n: int) -> List[str]:
        result = []
        for numerator in range(1, n):
            for denominator in range(numerator + 1, n + 1):
                if gcd(numerator, denominator) == 1:
                    result.append(f"{numerator}/{denominator}")
        return result