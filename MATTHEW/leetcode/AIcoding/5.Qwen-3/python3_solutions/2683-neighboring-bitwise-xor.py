class Solution:
    def minFlips(self, a: int, b: int, c: int) -> int:
        def flip(x, y):
            return bin(x ^ y).count('1')

        return flip(a ^ b, c)