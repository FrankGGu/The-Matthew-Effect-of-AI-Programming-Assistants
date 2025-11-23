class Solution:
    def sumSubseqWidths(self, A: List[int]) -> int:
        A.sort()
        n = len(A)
        mod = 10**9 + 7
        total = 0

        for i in range(n):
            total = (total + A[i] * (pow(2, i, mod) - pow(2, n - 1 - i, mod))) % mod

        return total