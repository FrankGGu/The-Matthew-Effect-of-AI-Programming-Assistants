class Solution:
    def largestOverlap(self, A: List[List[int]], B: List[List[int]]) -> int:
        def countOverlap(A, B, x_offset, y_offset):
            count = 0
            for i in range(len(A)):
                for j in range(len(A)):
                    if 0 <= i + x_offset < len(A) and 0 <= j + y_offset < len(A):
                        count += A[i][j] & B[i + x_offset][j + y_offset]
            return count

        max_overlap = 0
        for x in range(-len(A) + 1, len(A)):
            for y in range(-len(A) + 1, len(A)):
                max_overlap = max(max_overlap, countOverlap(A, B, x, y))

        return max_overlap