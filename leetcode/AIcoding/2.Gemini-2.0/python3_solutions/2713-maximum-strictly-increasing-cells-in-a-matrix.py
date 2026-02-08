class Solution:
    def maxIncreasingCells(self, matrix: List[List[int]]) -> int:
        m, n = len(matrix), len(matrix[0])
        values = []
        for i in range(m):
            for j in range(n):
                values.append(matrix[i][j])
        values = sorted(list(set(values)))

        dp = [[0] * n for _ in range(m)]
        row_max = [0] * m
        col_max = [0] * n

        for val in values:
            cells = []
            for i in range(m):
                for j in range(n):
                    if matrix[i][j] == val:
                        cells.append((i, j))

            temp_dp = {}
            for i, j in cells:
                temp_dp[(i, j)] = max(row_max[i], col_max[j]) + 1

            for i, j in cells:
                dp[i][j] = temp_dp[(i, j)]
                row_max[i] = max(row_max[i], dp[i][j])
                col_max[j] = max(col_max[j], dp[i][j])

        ans = 0
        for i in range(m):
            for j in range(n):
                ans = max(ans, dp[i][j])

        return ans