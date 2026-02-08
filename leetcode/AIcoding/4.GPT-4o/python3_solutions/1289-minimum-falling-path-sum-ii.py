class Solution:
    def minFallingPathSum(self, A: List[List[int]]) -> int:
        if not A:
            return 0

        n = len(A)
        m = len(A[0])

        for i in range(1, n):
            for j in range(m):
                min_val = float('inf')
                for k in range(m):
                    if k != j:
                        min_val = min(min_val, A[i-1][k])
                A[i][j] += min_val

        return min(A[-1])