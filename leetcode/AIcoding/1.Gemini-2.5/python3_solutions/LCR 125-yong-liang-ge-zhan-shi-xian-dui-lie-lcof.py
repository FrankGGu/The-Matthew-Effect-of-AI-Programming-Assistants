import math

class Solution:
    def minCost(self, books: list[int]) -> int:
        n = len(books)
        if n <= 1:
            return 0

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + books[i]

        dp = [[0] * n for _ in range(n)]

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1

                dp[i][j] = math.inf

                current_sum = prefix_sum[j+1] - prefix_sum[i]

                for k in range(i, j):
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k+1][j])

                dp[i][j] += current_sum

        return dp[0][n-1]