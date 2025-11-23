class Solution:
    def find2RowBinaryMatrix(self, rowSum: List[int], colSum: List[int]) -> List[List[int]]:
        m = len(rowSum)
        n = len(colSum)
        res = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                if rowSum[i] > 0 and colSum[j] > 0:
                    res[i][j] = 1
                    rowSum[i] -= 1
                    colSum[j] -= 1
        return res