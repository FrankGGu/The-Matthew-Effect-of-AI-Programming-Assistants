class Solution:
    def onesMinusZeros(self, grid: List[List[int]]) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        row_ones = [row.count(1) for row in grid]
        col_ones = [0] * n
        for j in range(n):
            for i in range(m):
                col_ones[j] += grid[i][j]
        result = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                ones = row_ones[i] + col_ones[j]
                zeros = (n - row_ones[i]) + (m - col_ones[j])
                result[i][j] = ones - zeros
        return result