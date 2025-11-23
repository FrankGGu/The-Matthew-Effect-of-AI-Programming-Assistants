class Solution:
    def diagonalSum(self, mat: List[List[int]]) -> int:
        n = len(mat)
        total = 0
        for i in range(n):
            total += mat[i][i]  # primary diagonal
            total += mat[i][n - 1 - i]  # secondary diagonal
        if n % 2 == 1:
            total -= mat[n // 2][n // 2]  # subtract the middle element if n is odd
        return total