class Solution:
    def luckyNumbers (self, matrix: List[List[int]]) -> List[int]:
        min_rows = [min(row) for row in matrix]
        max_cols = [max(matrix[i][j] for i in range(len(matrix))) for j in range(len(matrix[0]))]

        result = []
        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if matrix[i][j] == min_rows[i] and matrix[i][j] == max_cols[j]:
                    result.append(matrix[i][j])
        return result