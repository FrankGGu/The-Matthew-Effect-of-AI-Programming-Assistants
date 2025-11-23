import math
from collections import Counter
from functools import reduce

class Solution:
    def hasGroupsSizeX(self, deck: List[int]) -> bool:
        counts = Counter(deck).values()
        return reduce(math.gcd, counts) >= 2