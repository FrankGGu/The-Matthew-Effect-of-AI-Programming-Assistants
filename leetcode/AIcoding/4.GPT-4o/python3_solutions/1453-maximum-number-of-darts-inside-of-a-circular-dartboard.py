import math
from typing import List

class Solution:
    def numDartsInArea(self, darts: List[List[int]], r: int) -> int:
        count = 0
        r_squared = r * r

        for x, y in darts:
            if x * x + y * y <= r_squared:
                count += 1

        return count