class Solution:
    def corneredPath(self, grid: List[List[int]]) -> int:
        from collections import defaultdict

        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def count_trailing_zeros(num):
            count = 0
            while num % 10 == 0:
                count += 1
                num //= 10
            return count

        dp = [[[[0] * 4 for _ in range(4)] for _ in range(n)] for _ in range(m)]

        for i in range(m):
            for j in range(n):
                val = grid[i][j]
                zeros = count_trailing_zeros(val)
                for d in range(4):
                    dp[i][j][d][d] = zeros

        for i in range(m):
            for j in range(n):
                for d in range(4):
                    ni, nj = i + directions[d][0], j + directions[d][1]
                    if 0 <= ni < m and 0 <= nj < n:
                        for nd in range(4):
                            if nd != d:
                                dp[i][j][nd][d] = dp[ni][nj][nd][d] + dp[i][j][nd][d]

        max_zeros = 0
        for i in range(m):
            for j in range(n):
                for d1 in range(4):
                    for d2 in range(4):
                        if d1 != d2:
                            max_zeros = max(max_zeros, dp[i][j][d1][d2])

        return max_zeros