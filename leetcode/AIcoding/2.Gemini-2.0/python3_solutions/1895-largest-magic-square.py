class Solution:
    def largestMagicSquare(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        def is_magic_square(r, c, k):
            if r + k > m or c + k > n:
                return False

            magic_sum = 0
            for i in range(k):
                magic_sum += grid[r][c + i]

            for i in range(k):
                row_sum = 0
                for j in range(k):
                    row_sum += grid[r + i][c + j]
                if row_sum != magic_sum:
                    return False

            for j in range(k):
                col_sum = 0
                for i in range(k):
                    col_sum += grid[r + i][c + j]
                if col_sum != magic_sum:
                    return False

            diag1_sum = 0
            for i in range(k):
                diag1_sum += grid[r + i][c + i]
            if diag1_sum != magic_sum:
                return False

            diag2_sum = 0
            for i in range(k):
                diag2_sum += grid[r + i][c + k - 1 - i]
            if diag2_sum != magic_sum:
                return False

            return True

        max_k = min(m, n)
        for k in range(max_k, 0, -1):
            for r in range(m - k + 1):
                for c in range(n - k + 1):
                    if is_magic_square(r, c, k):
                        return k

        return 1