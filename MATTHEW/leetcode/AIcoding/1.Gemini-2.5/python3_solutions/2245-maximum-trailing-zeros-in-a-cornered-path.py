class Solution:
    def maxTrailingZeros(self, grid: list[list[int]]) -> int:
        M = len(grid)
        N = len(grid[0])

        def get_factors(n):
            c2 = 0
            c5 = 0
            while n > 0 and n % 2 == 0:
                c2 += 1
                n //= 2
            while n > 0 and n % 5 == 0:
                c5 += 1
                n //= 5
            return c2, c5

        factors_grid = [[(0, 0)] * N for _ in range(M)]
        for r in range(M):
            for c in range(N):
                factors_grid[r][c] = get_factors(grid[r][c])

        ps_row_left = [[(0, 0)] * N for _ in range(M)]
        ps_row_right = [[(0, 0)] * N for _ in range(M)]
        ps_col_up = [[(0, 0)] * N for _ in range(M)]
        ps_col_down = [[(0, 0)] * N for _ in range(M)]

        for r in range(M):
            ps_row_left[r][0] = factors_grid[r][0]
            for c in range(1, N):
                ps_row_left[r][c] = (ps_row_left[r][c-1][0] + factors_grid[r][c][0],
                                     ps_row_left[r][c-1][1] + factors_grid[r][c][1])

        for r in range(M):
            ps_row_right[r][N-1] = factors_grid[r][N-1]
            for c in range(N - 2, -1, -1):
                ps_row_right[r][c] = (ps_row_right[r][c+1][0] + factors_grid[r][c][0],
                                      ps_row_right[r][c+1][1] + factors_grid[r][c][1])

        for c in range(N):
            ps_col_up[0][c] = factors_grid[0][c]
            for r in range(1, M):
                ps_col_up[r][c] = (ps_col_up[r-1][c][0] + factors_grid[r][c][0],
                                   ps_col_up[r-1][c][1] + factors_grid[r][c][1])

        for c in range(N):
            ps_col_down[M-1][c] = factors_grid[M-1][c]
            for r in range(M - 2, -1, -1):
                ps_col_down[r][c] = (ps_col_down[r+1][c][0] + factors_grid[r][c][0],
                                     ps_col_down[r+1][c][1] + factors_grid[r][c][1])

        max_zeros = 0

        for r in range(M):
            for c in range(N):
                fg_c2, fg_c5 = factors_grid[r][c]

                # Path 1: Horizontal from left, Vertical from up
                total_c2 = ps_row_left[r][c][0] + ps_col_up[r][c][0] - fg_c2
                total_c5 = ps_row_left[r][c][1] + ps_col_up[r][c][1] - fg_c5
                max_zeros = max(max_zeros, min(total_c2, total_c5))

                # Path 2: Horizontal from left, Vertical from down
                total_c2 = ps_row_left[r][c][0] + ps_col_down[r][c][0] - fg_c2
                total_c5 = ps_row_left[r][c][1] + ps_col_down[r][c][1] - fg_c5
                max_zeros = max(max_zeros, min(total_c2, total_c5))

                # Path 3: Horizontal from right, Vertical from up
                total_c2 = ps_row_right[r][c][0] + ps_col_up[r][c][0] - fg_c2
                total_c5 = ps_row_right[r][c][1] + ps_col_up[r][c][1] - fg_c5
                max_zeros = max(max_zeros, min(total_c2, total_c5))

                # Path 4: Horizontal from right, Vertical from down
                total_c2 = ps_row_right[r][c][0] + ps_col_down[r][c][0] - fg_c2
                total_c5 = ps_row_right[r][c][1] + ps_col_down[r][c][1] - fg_c5
                max_zeros = max(max_zeros, min(total_c2, total_c5))

        return max_zeros