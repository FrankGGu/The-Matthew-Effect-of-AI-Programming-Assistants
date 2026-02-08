class Solution:
    def largest1BorderedSquare(self, grid: List[List[int]]) -> int:
        if not grid:
            return 0

        m, n = len(grid), len(grid[0])
        dp = [[[0, 0] for _ in range(n)] for _ in range(m)]
        max_side = 0

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    dp[i][j][0] = dp[i][j - 1][0] + 1 if j > 0 else 1
                    dp[i][j][1] = dp[i - 1][j][1] + 1 if i > 0 else 1

                    side = min(dp[i][j][0], dp[i][j][1])
                    for k in range(side):
                        if dp[i][j - k][1] >= side and dp[i - k][j][0] >= side:
                            max_side = max(max_side, side)
                            break

        return max_side * max_side