class Solution:
    def onesMinusZeros(self, grid: List[List[int]]) -> List[List[int]]:
        m = len(grid)
        n = len(grid[0])

        row_ones = [0] * m
        row_zeros = [0] * m
        col_ones = [0] * n
        col_zeros = [0] * n

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    row_ones[i] += 1
                    col_ones[j] += 1
                else:
                    row_zeros[i] += 1
                    col_zeros[j] += 1

        diff = [[0 for _ in range(n)] for _ in range(m)]
        for i in range(m):
            for j in range(n):
                diff[i][j] = row_ones[i] + col_ones[j] - row_zeros[i] - col_zeros[j]

        return diff