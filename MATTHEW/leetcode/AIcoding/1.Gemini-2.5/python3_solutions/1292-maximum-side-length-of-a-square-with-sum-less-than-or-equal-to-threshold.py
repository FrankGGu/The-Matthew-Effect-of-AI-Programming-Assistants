class Solution:
    def maxSideLength(self, mat: list[list[int]], threshold: int) -> int:
        m = len(mat)
        n = len(mat[0])

        # Compute 2D prefix sums
        # P[i][j] stores the sum of elements in the rectangle (0,0) to (i-1,j-1)
        P = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m):
            for j in range(n):
                P[i + 1][j + 1] = mat[i][j] + P[i][j + 1] + P[i + 1][j] - P[i][j]

        # Helper function to get the sum of a square
        # (r1, c1) is top-left, (r2, c2) is bottom-right (inclusive, 0-indexed)
        def get_sum(r1, c1, r2, c2):
            return P[r2 + 1][c2 + 1] - P[r1][c2 + 1] - P[r2 + 1][c1] + P[r1][c1]

        # Check if a square of side length 'k' exists with sum <= threshold
        def check(k):
            if k == 0:
                return True # A square of side 0 always has sum 0 <= threshold
            for r in range(m - k + 1):
                for c in range(n - k + 1):
                    if get_sum(r, c, r + k - 1, c + k - 1) <= threshold:
                        return True
            return False

        # Binary search for the maximum possible side length k
        low = 0
        high = min(m, n)
        ans = 0

        while low <= high:
            mid = (low + high) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans