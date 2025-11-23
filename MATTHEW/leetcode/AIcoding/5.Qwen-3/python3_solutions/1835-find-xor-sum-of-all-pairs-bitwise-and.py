class Solution:
    def xorSum(self, x: int, y: int) -> int:
        return (x & y) ^ (x ^ y)