class Solution:
    def restoreMatrix(self, rowSum: List[int], colSum: List[int]) -> List[List[int]]:
        m, n = len(rowSum), len(colSum)
        matrix = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                min_val = min(rowSum[i], colSum[j])
                matrix[i][j] = min_val
                rowSum[i] -= min_val
                colSum[j] -= min_val
        return matrix