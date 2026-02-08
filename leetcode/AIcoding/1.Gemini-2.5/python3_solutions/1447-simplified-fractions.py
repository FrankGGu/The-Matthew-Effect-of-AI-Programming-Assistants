import math

class Solution:
    def simplifiedFractions(self, n: int) -> list[str]:
        result = []
        for q in range(2, n + 1):
            for p in range(1, q):
                if math.gcd(p, q) == 1:
                    result.append(f"{p}/{q}")
        return result