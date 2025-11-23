class Solution:
    def chaseGame(self, A: List[int], B: List[int]) -> str:
        n = len(A)
        A.sort()
        B.sort()

        for i in range(n):
            if A[i] < B[i]:
                return "A"

        return "B"