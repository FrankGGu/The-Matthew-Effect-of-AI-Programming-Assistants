class Solution:
    def findStableArrays(self, n: int, A: List[int]) -> List[List[int]]:
        def isStable(B):
            for i in range(n):
                if B[i] != A[i] and (i > 0 and B[i-1] == B[i]):
                    return False
            return True

        def backtrack(start, B):
            if start == n:
                if isStable(B):
                    result.append(B[:])
                return
            for i in range(2):
                B[start] = i
                backtrack(start + 1, B)

        result = []
        backtrack(0, [0] * n)
        return result