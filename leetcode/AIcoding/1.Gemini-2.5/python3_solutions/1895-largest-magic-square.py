from typing import List

class Solution:
    def largestMagicSquare(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])

        # Precompute prefix sums for rows
        # prefix_row_sum[r][c] stores sum of grid[r][0]...grid[r][c-1]
        prefix_row_sum = [[0] * (n + 1) for _ in range(m)]
        for r in range(m):
            for c in range(n):
                prefix_row_sum[r][c+1] = prefix_row_sum[r][c] + grid[r][c]

        # Precompute prefix sums for columns
        # prefix_col_sum[r][c] stores sum of grid[0][c]...grid[r-1][c]
        prefix_col_sum = [[0] * n for _ in range(m + 1)]
        for c in range(n):
            for r in range(m):
                prefix_col_sum[r+1][c] = prefix_col_sum[r][c] + grid[r][c]

        # Iterate k from min(m, n) down to 1 (largest possible square size)
        for k in range(min(m, n), 0, -1):
            # Iterate over all possible top-left corners (r, c) for a k x k subgrid
            for r in range(m - k + 1):
                for c in range(n - k + 1):
                    # Check if the k x k subgrid starting at (r, c) is a magic square

                    # 1. Calculate main diagonal sum (top-left to bottom-right)
                    diag1_sum = 0
                    for i in range(k):
                        diag1_sum += grid[r+i][c+i]

                    # 2. Calculate anti-diagonal sum (top-right to bottom-left)
                    diag2_sum = 0
                    for i in range(k):
                        diag2_sum += grid[r+i][c+k-1-i]

                    # If diagonal sums are not equal, it's not a magic square
                    if diag1_sum != diag2_sum:
                        continue

                    target_sum = diag1_sum
                    is_magic = True

                    # 3. Check all k row sums using precomputed prefix_row_sum
                    for i in range(k):
                        current_row_sum = prefix_row_sum[r+i][c+k] - prefix_row_sum[r+i][c]
                        if current_row_sum != target_sum:
                            is_magic = False
                            break

                    if not is_magic:
                        continue

                    # 4. Check all k column sums using precomputed prefix_col_sum
                    for j in range(k):
                        current_col_sum = prefix_col_sum[r+k][c+j] - prefix_col_sum[r][c+j]
                        if current_col_sum != target_sum:
                            is_magic = False
                            break

                    # If all checks pass, we found a magic square of size k
                    # Since we iterate k downwards, this is the largest possible k
                    if is_magic:
                        return k

        # This line should theoretically not be reached because a 1x1 grid is always a magic square,
        # and k iterates down to 1.
        return 1