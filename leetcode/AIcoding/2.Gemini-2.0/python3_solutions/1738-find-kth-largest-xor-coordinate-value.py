class Solution:
    def kthLargestValue(self, matrix: List[List[int]], k: int) -> int:
        m, n = len(matrix), len(matrix[0])
        xor_matrix = [[0] * n for _ in range(m)]
        result = []
        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    xor_matrix[i][j] = matrix[i][j]
                elif i == 0:
                    xor_matrix[i][j] = xor_matrix[i][j - 1] ^ matrix[i][j]
                elif j == 0:
                    xor_matrix[i][j] = xor_matrix[i - 1][j] ^ matrix[i][j]
                else:
                    xor_matrix[i][j] = xor_matrix[i - 1][j] ^ xor_matrix[i][j - 1] ^ xor_matrix[i - 1][j - 1] ^ matrix[i][j]
                result.append(xor_matrix[i][j])
        result.sort(reverse=True)
        return result[k - 1]