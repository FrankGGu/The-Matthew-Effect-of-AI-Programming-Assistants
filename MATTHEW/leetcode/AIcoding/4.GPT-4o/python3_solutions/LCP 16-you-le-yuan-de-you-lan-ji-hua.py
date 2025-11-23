class Solution:
    def maxEnjoyment(self, n: int, enjoy: List[List[int]]) -> int:
        dp = [[0] * (n + 1) for _ in range(len(enjoy) + 1)]

        for i in range(1, len(enjoy) + 1):
            for j in range(1, n + 1):
                dp[i][j] = dp[i - 1][j]
                if j >= enjoy[i - 1][0]:
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - enjoy[i - 1][0]] + enjoy[i - 1][1])

        return dp[len(enjoy)][n]