class Solution:
    def palindromePartition(self, s: str, k: int) -> int:
        n = len(s)
        # Precompute the cost to make s[i..j] palindrome
        cost = [[0] * n for _ in range(n)]
        for l in range(2, n + 1):
            for i in range(n - l + 1):
                j = i + l - 1
                cost[i][j] = cost[i + 1][j - 1] + (0 if s[i] == s[j] else 1)

        # DP table: dp[i][j] = min changes to split s[0..i-1] into j palindromes
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0
        for i in range(1, n + 1):
            for j in range(1, k + 1):
                for m in range(j - 1, i):
                    dp[i][j] = min(dp[i][j], dp[m][j - 1] + cost[m][i - 1])

        return dp[n][k]