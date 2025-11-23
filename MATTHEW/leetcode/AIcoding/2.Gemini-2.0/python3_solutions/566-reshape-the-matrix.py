class Solution:
    def matrixReshape(self, mat: list[list[int]], r: int, c: int) -> list[list[int]]:
        m = len(mat)
        n = len(mat[0])
        if m * n != r * c:
            return mat

        nums = []
        for i in range(m):
            for j in range(n):
                nums.append(mat[i][j])

        reshaped_matrix = []
        for i in range(r):
            row = []
            for j in range(c):
                row.append(nums[i * c + j])
            reshaped_matrix.append(row)

        return reshaped_matrix