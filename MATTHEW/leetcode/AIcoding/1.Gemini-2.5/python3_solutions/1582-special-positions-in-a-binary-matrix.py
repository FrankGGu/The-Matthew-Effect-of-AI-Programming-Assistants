class Solution:
    def numSpecial(self, mat: list[list[int]]) -> int:
        m = len(mat)
        n = len(mat[0])

        row_sums = [0] * m
        col_sums = [0] * n

        for i in range(m):
            for j in range(n):
                if mat[i][j] == 1:
                    row_sums[i] += 1
                    col_sums[j] += 1

        special_positions_count = 0
        for i in range(m):
            for j in range(n):
                if mat[i][j] == 1 and row_sums[i] == 1 and col_sums[j] == 1:
                    special_positions_count += 1

        return special_positions_count