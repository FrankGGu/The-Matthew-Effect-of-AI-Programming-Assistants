class Solution:
    def maxTrailingZeros(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        # Precompute the number of 2s and 5s for each cell
        factors = [[(0, 0) for _ in range(n)] for __ in range(m)]
        for i in range(m):
            for j in range(n):
                num = grid[i][j]
                cnt2, cnt5 = 0, 0
                while num % 2 == 0:
                    cnt2 += 1
                    num = num // 2
                while num % 5 == 0:
                    cnt5 += 1
                    num = num // 5
                factors[i][j] = (cnt2, cnt5)

        # Compute prefix sums for rows and columns
        row_prefix = [[(0, 0) for _ in range(n + 1)] for __ in range(m)]
        for i in range(m):
            for j in range(n):
                row_prefix[i][j + 1] = (row_prefix[i][j][0] + factors[i][j][0], row_prefix[i][j][1] + factors[i][j][1])

        col_prefix = [[(0, 0) for _ in range(n)] for __ in range(m + 1)]
        for j in range(n):
            for i in range(m):
                col_prefix[i + 1][j] = (col_prefix[i][j][0] + factors[i][j][0], col_prefix[i][j][1] + factors[i][j][1])

        max_zeros = 0
        for i in range(m):
            for j in range(n):
                # Four possible paths:
                # 1. Left to right then up
                left2 = row_prefix[i][j + 1][0] - row_prefix[i][0][0]
                left5 = row_prefix[i][j + 1][1] - row_prefix[i][0][1]
                up2 = col_prefix[i][j][0] - col_prefix[0][j][0]
                up5 = col_prefix[i][j][1] - col_prefix[0][j][1]
                total2 = left2 + up2
                total5 = left5 + up5
                max_zeros = max(max_zeros, min(total2, total5))

                # 2. Left to right then down
                down2 = col_prefix[m][j][0] - col_prefix[i][j][0]
                down5 = col_prefix[m][j][1] - col_prefix[i][j][1]
                total2 = left2 + down2
                total5 = left5 + down5
                max_zeros = max(max_zeros, min(total2, total5))

                # 3. Right to left then up
                right2 = row_prefix[i][n][0] - row_prefix[i][j][0]
                right5 = row_prefix[i][n][1] - row_prefix[i][j][1]
                up2 = col_prefix[i][j][0] - col_prefix[0][j][0]
                up5 = col_prefix[i][j][1] - col_prefix[0][j][1]
                total2 = right2 + up2
                total5 = right5 + up5
                max_zeros = max(max_zeros, min(total2, total5))

                # 4. Right to left then down
                down2 = col_prefix[m][j][0] - col_prefix[i][j][0]
                down5 = col_prefix[m][j][1] - col_prefix[i][j][1]
                total2 = right2 + down2
                total5 = right5 + down5
                max_zeros = max(max_zeros, min(total2, total5))

        return max_zeros