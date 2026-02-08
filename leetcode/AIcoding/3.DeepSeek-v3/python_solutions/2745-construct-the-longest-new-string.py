class Solution:
    def longestString(self, x: int, y: int, z: int) -> int:
        min_xy = min(x, y)
        if x == y:
            return (x + y + z) * 2
        else:
            return (min_xy * 2 + 1 + z) * 2