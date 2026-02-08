class Solution:
    def numWays(self, n: int, relation: List[List[int]], k: int) -> int:
        dp = [[0] * n for _ in range(k + 1)]
        dp[0][0] = 1

        for i in range(1, k + 1):
            for src, dst in relation:
                dp[i][dst] += dp[i - 1][src]

        return dp[k][n - 1]