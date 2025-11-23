class Solution:
    def largestMagicSquare(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        row_sums = [[0] * n for _ in range(m)]
        col_sums = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                row_sums[i][j] = grid[i][j] + (row_sums[i][j-1] if j > 0 else 0)
                col_sums[i][j] = grid[i][j] + (col_sums[i-1][j] if i > 0 else 0)

        max_len = 1
        for k in range(2, min(m, n) + 1):
            for i in range(m - k + 1):
                for j in range(n - k + 1):
                    target = row_sums[i][j + k - 1]
                    valid = True
                    for x in range(i, i + k):
                        if row_sums[x][j + k - 1] - (row_sums[x][j - 1] if j > 0 else 0) != target:
                            valid = False
                            break
                    if not valid:
                        continue
                    for y in range(j, j + k):
                        if col_sums[i + k - 1][y] - (col_sums[i - 1][y] if i > 0 else 0) != target:
                            valid = False
                            break
                    if valid:
                        max_len = k
        return max_len