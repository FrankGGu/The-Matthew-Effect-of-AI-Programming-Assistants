class Solution:
    def findThePrefixCommonArray(self, A: list[int], B: list[int]) -> list[int]:
        n = len(A)
        C = [0] * n
        set_A = set()
        set_B = set()

        for i in range(n):
            set_A.add(A[i])
            set_B.add(B[i])
            C[i] = len(set_A.intersection(set_B))

        return C