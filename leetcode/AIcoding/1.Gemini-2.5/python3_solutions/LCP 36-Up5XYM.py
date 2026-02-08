import collections
import math
from functools import reduce

class Solution:
    def hasGroupsSizeX(self, deck: list[int]) -> bool:
        if not deck:
            return False

        counts = collections.Counter(deck)

        freqs = list(counts.values())

        # Calculate the greatest common divisor (GCD) of all frequencies.
        # If the GCD of all frequencies is X, then we can form groups of size X.
        # The problem requires X >= 2.
        # functools.reduce applies math.gcd iteratively to all elements in freqs.
        # Since deck is not empty, freqs will contain at least one element,
        # so reduce will not be called on an empty sequence.
        common_divisor = reduce(math.gcd, freqs)

        return common_divisor >= 2