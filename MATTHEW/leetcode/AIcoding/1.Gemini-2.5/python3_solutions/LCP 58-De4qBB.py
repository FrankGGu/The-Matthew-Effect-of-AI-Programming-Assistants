import math

class Solution:
    def minCost(self, blocks: list[int]) -> int:
        n = len(blocks)
        if n <= 1:
            return 0

        max_val = [[0] * n for _ in range(n)]
        for i in range(n):
            max_val[i][i] = blocks[i]
            for j in range(i + 1, n):
                max_val[i][j] = max(max_val[i][j - 1], blocks[j])

        dp = [[math.inf] * n for _ in range(n)]
        for i in range(n):
            dp[i][i] = 0

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                for k in range(i, j):
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k + 1][j] + max_val[i][j])

        return dp[0][n - 1]