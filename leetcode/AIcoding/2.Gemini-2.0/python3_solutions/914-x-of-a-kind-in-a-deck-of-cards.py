from collections import Counter
import math

class Solution:
    def hasGroupsSizeX(self, deck: list[int]) -> bool:
        counts = Counter(deck)
        gcd = 0
        for count in counts.values():
            gcd = math.gcd(gcd, count)
        return gcd >= 2