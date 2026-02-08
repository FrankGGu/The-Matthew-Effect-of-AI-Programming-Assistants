class Solution:
    def kthGrammar(self, n: int, k: int) -> int:
        if n == 1:
            return 0

        half_len = 2**(n-2)

        if k <= half_len:
            return self.kthGrammar(n-1, k)
        else:
            return 1 - self.kthGrammar(n-1, k - half_len)