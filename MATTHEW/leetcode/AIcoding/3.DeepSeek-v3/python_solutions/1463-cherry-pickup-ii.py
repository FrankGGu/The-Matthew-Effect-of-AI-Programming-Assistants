class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        dp = [[[ -1 for _ in range(n) ] for __ in range(n) ] for ___ in range(m)]

        dp[0][0][n-1] = grid[0][0] + grid[0][n-1]

        for i in range(1, m):
            for j1 in range(n):
                for j2 in range(n):
                    max_prev = -1
                    for dj1 in [-1, 0, 1]:
                        for dj2 in [-1, 0, 1]:
                            prev_j1 = j1 + dj1
                            prev_j2 = j2 + dj2
                            if 0 <= prev_j1 < n and 0 <= prev_j2 < n and dp[i-1][prev_j1][prev_j2] != -1:
                                max_prev = max(max_prev, dp[i-1][prev_j1][prev_j2])
                    if max_prev != -1:
                        if j1 == j2:
                            dp[i][j1][j2] = max_prev + grid[i][j1]
                        else:
                            dp[i][j1][j2] = max_prev + grid[i][j1] + grid[i][j2]

        res = 0
        for j1 in range(n):
            for j2 in range(n):
                res = max(res, dp[m-1][j1][j2])

        return res