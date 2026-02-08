class Solution:
    def minFlips(self, a: int, b: int, c: int) -> int:
        flips = 0
        for i in range(32):
            bitA = (a >> i) & 1
            bitB = (b >> i) & 1
            bitC = (c >> i) & 1

            if bitC == 1:
                if bitA == 0 and bitB == 0:
                    flips += 1
            else:
                flips += bitA + bitB
        return flips