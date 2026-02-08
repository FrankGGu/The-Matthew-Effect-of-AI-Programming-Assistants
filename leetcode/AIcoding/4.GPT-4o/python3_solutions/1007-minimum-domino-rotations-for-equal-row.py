class Solution:
    def minDominoRotations(self, A: List[int], B: List[int]) -> int:
        def check(x):
            rotations_A = rotations_B = 0
            for a, b in zip(A, B):
                if a != x and b != x:
                    return float('inf')
                elif a != x:
                    rotations_A += 1
                elif b != x:
                    rotations_B += 1
            return min(rotations_A, rotations_B)

        result = check(A[0])
        if result != float('inf'):
            return result
        return check(B[0])