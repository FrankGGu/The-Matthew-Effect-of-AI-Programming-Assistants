class Solution:
    def sumOfSubseqWidths(self, A: List[int]) -> int:
        A.sort()
        mod = 10**9 + 7
        n = len(A)
        total = 0
        for i in range(n):
            total += (A[i] * (1 << i) - A[i] * (1 << (n - 1 - i))) % mod
            total %= mod
        return total