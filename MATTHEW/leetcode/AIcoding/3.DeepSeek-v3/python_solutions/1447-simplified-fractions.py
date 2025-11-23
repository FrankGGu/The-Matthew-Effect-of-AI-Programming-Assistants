class Solution:
    def simplifiedFractions(self, n: int) -> List[str]:
        res = []
        for denominator in range(2, n + 1):
            for numerator in range(1, denominator):
                if math.gcd(numerator, denominator) == 1:
                    res.append(f"{numerator}/{denominator}")
        return res