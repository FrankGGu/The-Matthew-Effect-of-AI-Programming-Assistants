class Solution:
    def maxProductPath(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        dp_min = [[0] * n for _ in range(m)]
        dp_max = [[0] * n for _ in range(m)]

        MOD = 10**9 + 7

        for i in range(m):
            for j in range(n):
                val = grid[i][j]

                if i == 0 and j == 0:
                    dp_min[i][j] = val
                    dp_max[i][j] = val
                else:
                    prev_min_options = []
                    prev_max_options = []

                    if i > 0:
                        prev_min_options.append(dp_min[i-1][j])
                        prev_max_options.append(dp_max[i-1][j])
                    if j > 0:
                        prev_min_options.append(dp_min[i][j-1])
                        prev_max_options.append(dp_max[i][j-1])

                    if val >= 0:
                        dp_min[i][j] = val * min(prev_min_options)
                        dp_max[i][j] = val * max(prev_max_options)
                    else: # val < 0
                        dp_min[i][j] = val * max(prev_max_options)
                        dp_max[i][j] = val * min(prev_min_options)

        result = dp_max[m-1][n-1]

        if result < 0:
            return -1
        else:
            return result % MOD