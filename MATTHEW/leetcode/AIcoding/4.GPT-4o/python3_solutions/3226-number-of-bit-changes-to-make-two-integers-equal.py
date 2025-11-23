class Solution:
    def convertInteger(self, A: int, B: int) -> int:
        return bin(A ^ B).count('1')