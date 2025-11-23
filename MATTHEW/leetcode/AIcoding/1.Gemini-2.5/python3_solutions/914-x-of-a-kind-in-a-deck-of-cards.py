import collections
import math

class Solution:
    def hasGroupsSizeX(self, deck: list[int]) -> bool:
        counts = collections.Counter(deck)

        if not counts:
            return False

        first_gcd = 0
        for count in counts.values():
            if first_gcd == 0:
                first_gcd = count
            else:
                first_gcd = math.gcd(first_gcd, count)

        return first_gcd >= 2