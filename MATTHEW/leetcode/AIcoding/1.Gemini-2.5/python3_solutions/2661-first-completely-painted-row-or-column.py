class Solution:
    def firstCompleteIndex(self, mat: list[list[int]], arr: list[int]) -> int:
        m = len(mat)
        n = len(mat[0])

        val_to_coords = {}
        for r in range(m):
            for c in range(n):
                val_to_coords[mat[r][c]] = (r, c)

        row_counts = [0] * m
        col_counts = [0] * n

        for k in range(len(arr)):
            num = arr[k]
            r, c = val_to_coords[num]

            row_counts[r] += 1
            col_counts[c] += 1

            if row_counts[r] == n or col_counts[c] == m:
                return k

        return -1 # Should not be reached based on problem constraints