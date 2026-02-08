import math

class Solution:
    def solve(self, N: int, M: int) -> bool:
        if N > M:
            N, M = M, N

        phi = (1 + math.sqrt(5)) / 2

        k = M - N

        return N != math.floor(k * phi)