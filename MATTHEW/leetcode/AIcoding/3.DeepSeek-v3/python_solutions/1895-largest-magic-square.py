class Solution:
    def largestMagicSquare(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        prefix_row = [[0] * (n + 1) for _ in range(m)]
        prefix_col = [[0] * (m + 1) for _ in range(n)]

        for i in range(m):
            for j in range(n):
                prefix_row[i][j + 1] = prefix_row[i][j] + grid[i][j]

        for j in range(n):
            for i in range(m):
                prefix_col[j][i + 1] = prefix_col[j][i] + grid[i][j]

        max_size = 1

        for i in range(m):
            for j in range(n):
                max_possible = min(m - i, n - j)
                for size in range(max_possible, 1, -1):
                    if size <= max_size:
                        break
                    target = None
                    valid = True

                    diag_sum = 0
                    anti_diag_sum = 0

                    for k in range(size):
                        diag_sum += grid[i + k][j + k]
                        anti_diag_sum += grid[i + k][j + size - 1 - k]

                    if diag_sum != anti_diag_sum:
                        continue

                    target = diag_sum

                    for x in range(i, i + size):
                        row_sum = prefix_row[x][j + size] - prefix_row[x][j]
                        if row_sum != target:
                            valid = False
                            break
                    if not valid:
                        continue

                    for y in range(j, j + size):
                        col_sum = prefix_col[y][i + size] - prefix_col[y][i]
                        if col_sum != target:
                            valid = False
                            break

                    if valid:
                        max_size = max(max_size, size)
                        break

        return max_size