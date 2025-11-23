class Solution:
    def minimumTravelTime(self, A: List[int], B: List[int]) -> int:
        n = len(A)
        A.sort()
        B.sort()

        total_time = 0
        for i in range(n):
            total_time += A[i] + B[i]

        return total_time