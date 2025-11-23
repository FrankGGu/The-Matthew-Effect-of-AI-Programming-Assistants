class Solution:
    def largestSubmatrix(self, matrix: List[List[int]]) -> int:
        m = len(matrix)
        n = len(matrix[0])
        res = 0

        for i in range(1, m):
            for j in range(n):
                if matrix[i][j] == 1:
                    matrix[i][j] += matrix[i-1][j]

        for i in range(m):
            matrix[i].sort(reverse=True)
            for j in range(n):
                height = matrix[i][j]
                width = j + 1
                res = max(res, height * width)

        return res