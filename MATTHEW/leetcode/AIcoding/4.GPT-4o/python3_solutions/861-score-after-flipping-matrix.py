class Solution:
    def matrixScore(self, A: List[List[int]]) -> int:
        R, C = len(A), len(A[0])

        # Step 1: Flip rows to ensure the first column is all 1s
        for r in range(R):
            if A[r][0] == 0:
                for c in range(C):
                    A[r][c] ^= 1

        # Step 2: Calculate the score for each column
        score = 0
        for c in range(C):
            ones_count = sum(A[r][c] for r in range(R))
            score += max(ones_count, R - ones_count) * (1 << (C - 1 - c))

        return score