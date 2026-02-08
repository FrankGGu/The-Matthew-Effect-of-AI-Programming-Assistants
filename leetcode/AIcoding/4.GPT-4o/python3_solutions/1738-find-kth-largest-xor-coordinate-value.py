class Solution:
    def kthLargestValue(self, matrix: List[List[int]], k: int) -> int:
        m, n = len(matrix), len(matrix[0])
        xor_matrix = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                xor_matrix[i][j] = matrix[i][j]
                if i > 0:
                    xor_matrix[i][j] ^= xor_matrix[i - 1][j]
                if j > 0:
                    xor_matrix[i][j] ^= xor_matrix[i][j - 1]
                if i > 0 and j > 0:
                    xor_matrix[i][j] ^= xor_matrix[i - 1][j - 1]

        flat_list = [xor_matrix[i][j] for i in range(m) for j in range(n)]
        flat_list.sort(reverse=True)

        return flat_list[k - 1]