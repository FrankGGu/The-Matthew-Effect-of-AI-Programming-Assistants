class Solution:
    def maxValueOfCoins(self, piles: List[List[int]], k: int) -> int:
        n = len(piles)
        dp = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                dp[i][j] = dp[i - 1][j]
                current_sum = 0
                for l in range(1, min(j, len(piles[i - 1])) + 1):
                    current_sum += piles[i - 1][l - 1]
                    if dp[i - 1][j - l] + current_sum > dp[i][j]:
                        dp[i][j] = dp[i - 1][j - l] + current_sum
        return dp[n][k]