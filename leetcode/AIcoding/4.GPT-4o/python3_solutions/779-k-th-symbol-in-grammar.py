class Solution:
    def kthGrammar(self, N: int, K: int) -> int:
        if N == 1:
            return 0
        mid = 2 ** (N - 1) // 2
        if K <= mid:
            return self.kthGrammar(N - 1, K)
        else:
            return 1 - self.kthGrammar(N - 1, K - mid)