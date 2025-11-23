class Solution:
    def numSpecial(self, mat: List[List[int]]) -> int:
        row_count = len(mat)
        col_count = len(mat[0]) if row_count > 0 else 0

        row_sum = [sum(mat[i]) for i in range(row_count)]
        col_sum = [sum(mat[i][j] for i in range(row_count)) for j in range(col_count)]

        special_positions = 0

        for i in range(row_count):
            for j in range(col_count):
                if mat[i][j] == 1 and row_sum[i] == 1 and col_sum[j] == 1:
                    special_positions += 1

        return special_positions