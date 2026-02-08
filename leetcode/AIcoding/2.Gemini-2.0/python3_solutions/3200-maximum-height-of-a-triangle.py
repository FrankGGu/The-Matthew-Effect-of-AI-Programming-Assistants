import math

class Solution:
    def maxTriangleHeight(self, base: int, area: int) -> int:
        return math.floor(2 * area / base)