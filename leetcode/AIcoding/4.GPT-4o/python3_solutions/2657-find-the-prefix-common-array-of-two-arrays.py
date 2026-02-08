class Solution:
    def findThePrefixCommonArray(self, A: List[int], B: List[int]) -> List[int]:
        common = []
        countA, countB = 0, 0
        for i in range(len(A)):
            countA += A[i] in B[:i+1]
            countB += B[i] in A[:i+1]
            common.append(countA)
        return common