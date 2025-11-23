class Solution:
    def countPalindromicSubsequences(self, S: str) -> int:
        MOD = 10**9 + 7
        n = len(S)
        dp = [[0] * n for _ in range(n)]
        for i in range(n):
            dp[i][i] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                if S[i] == S[j]:
                    left = i + 1
                    right = j - 1
                    while left <= right and S[left] != S[i]:
                        left += 1
                    while left <= right and S[right] != S[i]:
                        right -= 1
                    if left > right:
                        dp[i][j] = dp[i+1][j-1] * 2 + 2
                    elif left == right:
                        dp[i][j] = dp[i+1][j-1] * 2 + 1
                    else:
                        dp[i][j] = dp[i+1][j-1] * 2 - dp[left+1][right-1]
                else:
                    dp[i][j] = dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1]
                dp[i][j] %= MOD
        return dp[0][n-1]