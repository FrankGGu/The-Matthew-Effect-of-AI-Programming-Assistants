class Solution:
    def minNumber(self, A: List[int], B: List[int]) -> str:
        A, B = set(A), set(B)
        common = A & B
        if common:
            return str(min(common))

        minA = min(A)
        minB = min(B)
        return str(min(minA, minB)) + str(max(minA, minB))