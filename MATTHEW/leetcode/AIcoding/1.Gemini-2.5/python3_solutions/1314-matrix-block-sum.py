class Solution:
    def matrixBlockSum(self, mat: list[list[int]], k: int) -> list[list[int]]:
        m, n = len(mat), len(mat[0])

        # Create a 2D prefix sum array (integral image)
        # P[i][j] will store the sum of all elements in the rectangle (0,0) to (i-1,j-1)
        P = [[0] * (n + 1) for _ in range(m + 1)]

        for r in range(m):
            for c in range(n):
                P[r + 1][c + 1] = mat[r][c] + P[r][c + 1] + P[r + 1][c] - P[r][c]

        ans = [[0] * n for _ in range(m)]

        for r in range(m):
            for c in range(n):
                # Determine the boundaries of the block
                r1 = max(0, r - k)
                c1 = max(0, c - k)
                r2 = min(m - 1, r + k)
                c2 = min(n - 1, c + k)

                # Calculate the sum of the block using the prefix sum array
                # Sum(r1, c1, r2, c2) = P[r2+1][c2+1] - P[r1][c2+1] - P[r2+1][c1] + P[r1][c1]
                ans[r][c] = P[r2 + 1][c2 + 1] - P[r1][c2 + 1] - P[r2 + 1][c1] + P[r1][c1]

        return ans