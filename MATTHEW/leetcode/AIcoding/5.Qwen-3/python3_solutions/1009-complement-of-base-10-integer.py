class Solution:
    def bitwiseComplement(self, N: int) -> int:
        if N == 0:
            return 1
        mask = 1
        while mask < N:
            mask = (mask << 1) | 1
        return N ^ mask