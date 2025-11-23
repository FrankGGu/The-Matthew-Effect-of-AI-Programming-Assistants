from typing import List

class Solution:
    def modifyColumns(self, mat: List[List[int]]) -> List[List[int]]:
        if not mat or not mat[0]:
            return mat

        num_rows = len(mat)
        num_cols = len(mat[0])

        modified_mat = [row[:] for row in mat]

        for c in range(num_cols):
            if c % 2 == 0:
                for r in range(num_rows):
                    modified_mat[r][c] += 1
            else:
                for r in range(num_rows):
                    modified_mat[r][c] -= 1

        return modified_mat