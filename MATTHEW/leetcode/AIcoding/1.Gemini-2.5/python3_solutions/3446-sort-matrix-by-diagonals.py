class Solution:
    def diagonalSort(self, mat: list[list[int]]) -> list[list[int]]:
        m = len(mat)
        n = len(mat[0])

        # Iterate through all possible diagonal identifiers (r - c)
        # The diagonal identifier 'd' ranges from -(n-1) to (m-1)
        for d in range(-(n - 1), m):
            diagonal_elements = []

            # Determine the starting point (r0, c0) for the current diagonal
            r0 = 0
            c0 = 0
            if d >= 0:
                r0 = d
                c0 = 0
            else: # d < 0
                r0 = 0
                c0 = -d

            # Collect elements of the current diagonal
            r, c = r0, c0
            while r < m and c < n:
                diagonal_elements.append(mat[r][c])
                r += 1
                c += 1

            # Sort the collected elements
            diagonal_elements.sort()

            # Place the sorted elements back into the matrix
            r, c = r0, c0
            k = 0
            while r < m and c < n:
                mat[r][c] = diagonal_elements[k]
                r += 1
                c += 1
                k += 1

        return mat