class Solution:
    def luckyNumbers (self, matrix: List[List[int]]) -> List[int]:
        return [matrix[i][j] for i in range(len(matrix)) for j in range(len(matrix[0])) 
                if matrix[i][j] == min(matrix[i]) and matrix[i][j] == max(row[j] for row in matrix)]