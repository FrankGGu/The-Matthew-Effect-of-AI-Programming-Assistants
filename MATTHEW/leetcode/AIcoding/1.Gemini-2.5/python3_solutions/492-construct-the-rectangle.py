import math

class Solution:
    def constructRectangle(self, area: int) -> list[int]:
        w = int(math.sqrt(area))
        while area % w != 0:
            w -= 1
        l = area // w
        return [l, w]