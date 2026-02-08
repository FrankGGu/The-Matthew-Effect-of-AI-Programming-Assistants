class Solution:
    def minimumSeconds(self, A: List[int]) -> int:
        n = len(A)
        total_seconds = 0

        for i in range(n):
            if A[i] > 0:
                total_seconds += A[i]

        for i in range(1, n):
            if A[i] > A[i - 1]:
                total_seconds += A[i] - A[i - 1]

        return total_seconds