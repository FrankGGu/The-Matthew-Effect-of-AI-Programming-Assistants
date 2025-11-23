class Solution:
    def diagonalSum(self, mat: list[list[int]]) -> int:
        n = len(mat)
        sum_val = 0
        for i in range(n):
            sum_val += mat[i][i]
            sum_val += mat[i][n - 1 - i]
        if n % 2 == 1:
            sum_val -= mat[n // 2][n // 2]
        return sum_val