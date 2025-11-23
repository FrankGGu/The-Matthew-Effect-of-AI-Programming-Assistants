class Solution:
    def clumsy(self, N: int) -> int:
        if N == 1:
            return 1
        if N == 2:
            return 2
        if N == 3:
            return 6

        res = N * (N - 1) // (N - 2) + (N - 3)
        N -= 4

        while N > 0:
            term = -N * (N - 1) // (N - 2) + (N - 3)
            res += term
            N -= 4

        return res