class Solution:
    def matrixReshape(self, mat: list[list[int]], r: int, c: int) -> list[list[int]]:
        rows_mat = len(mat)
        cols_mat = len(mat[0])

        if rows_mat * cols_mat != r * c:
            return mat

        flat_elements = []
        for i in range(rows_mat):
            for j in range(cols_mat):
                flat_elements.append(mat[i][j])

        reshaped_mat = []
        element_idx = 0
        for i in range(r):
            current_row = []
            for j in range(c):
                current_row.append(flat_elements[element_idx])
                element_idx += 1
            reshaped_mat.append(current_row)

        return reshaped_mat