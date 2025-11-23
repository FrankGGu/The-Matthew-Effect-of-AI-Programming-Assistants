class Solution:
    def countSubmatrices(self, matrix: list[list[int]], k: int) -> int:
        m, n = len(matrix), len(matrix[0])
        prefix_sum = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                prefix_sum[i][j] = prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1] + matrix[i - 1][j - 1]

        count = 0
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                for r in range(i, m + 1):
                    for c in range(j, n + 1):
                        submatrix_sum = prefix_sum[r][c] - prefix_sum[i - 1][c] - prefix_sum[r][j - 1] + prefix_sum[i - 1][j - 1]
                        if submatrix_sum <= k:
                            count += 1

        return count