class Solution:
    def magicalSequences(self, A: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(A)
        total_sum = 0

        for i in range(n):
            for j in range(i, n):
                product = 1
                for k in range(i, j + 1):
                    product *= A[k]
                    product %= MOD
                total_sum += product
                total_sum %= MOD

        return total_sum