import math

class Solution:
    def numberOfWays(self, startPos: int, endPos: int, k: int) -> int:
        diff = endPos - startPos

        if (diff + k) % 2 != 0:
            return 0

        if abs(diff) > k:
            return 0

        p = (diff + k) // 2

        return math.comb(k, p)