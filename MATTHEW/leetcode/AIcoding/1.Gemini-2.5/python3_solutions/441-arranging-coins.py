import math

class Solution:
    def arrangeCoins(self, n: int) -> int:
        discriminant = 1 + 8 * n
        k_float = (math.sqrt(discriminant) - 1) / 2
        return int(k_float)