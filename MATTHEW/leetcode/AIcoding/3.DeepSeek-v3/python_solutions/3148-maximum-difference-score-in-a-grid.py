class Solution:
    def maxScore(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        min_val = [[float('inf')] * n for _ in range(m)]
        res = -float('inf')

        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    min_val[i][j] = grid[i][j]
                else:
                    if i > 0:
                        min_val[i][j] = min(min_val[i][j], min_val[i-1][j])
                    if j > 0:
                        min_val[i][j] = min(min_val[i][j], min_val[i][j-1])
                    res = max(res, grid[i][j] - min_val[i][j])
                    min_val[i][j] = min(min_val[i][j], grid[i][j])

        return res