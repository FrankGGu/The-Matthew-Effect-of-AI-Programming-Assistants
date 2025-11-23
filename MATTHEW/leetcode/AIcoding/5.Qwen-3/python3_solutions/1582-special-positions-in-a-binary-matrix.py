class Solution:
    def numSpecial(self, matrix: List[List[int]]) -> int:
        rows = [sum(row) for row in matrix]
        cols = [0] * len(matrix[0])
        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                cols[j] += matrix[i][j]
        count = 0
        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if rows[i] == 1 and cols[j] == 1 and matrix[i][j] == 1:
                    count += 1
        return count