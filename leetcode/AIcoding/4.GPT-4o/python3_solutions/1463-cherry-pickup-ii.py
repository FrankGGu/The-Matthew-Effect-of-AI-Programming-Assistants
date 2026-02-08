class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])
        dp = [[-1] * col for _ in range(col)]

        for j in range(col):
            if grid[0][j] == 1:
                dp[j][j] = 1

        for i in range(1, row):
            new_dp = [[-1] * col for _ in range(col)]
            for j1 in range(col):
                for j2 in range(col):
                    if dp[j1][j2] != -1:
                        for new_j1 in range(max(0, j1 - 1), min(col, j1 + 2)):
                            for new_j2 in range(max(0, j2 - 1), min(col, j2 + 2)):
                                new_dp[new_j1][new_j2] = max(new_dp[new_j1][new_j2], dp[j1][j2] + grid[i][new_j1] + (grid[i][new_j2] if new_j1 != new_j2 else 0))
            dp = new_dp

        return max(max(row) for row in dp)