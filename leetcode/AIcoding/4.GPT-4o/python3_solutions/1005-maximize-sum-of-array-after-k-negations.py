class Solution:
    def largestSumAfterKNegations(self, A: List[int], K: int) -> int:
        A.sort()
        for i in range(len(A)):
            if K > 0 and A[i] < 0:
                A[i] = -A[i]
                K -= 1
        if K > 0 and K % 2 == 1:
            A.sort()
            A[0] = -A[0]
        return sum(A)