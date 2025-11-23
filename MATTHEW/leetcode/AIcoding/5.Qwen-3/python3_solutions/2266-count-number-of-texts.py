class Solution:
    def countTexts(self, A: str) -> int:
        mod = 10**9 + 7
        n = len(A)
        dp = [0] * (n + 1)
        dp[0] = 1
        for i in range(1, n + 1):
            if A[i - 1] == ' ':
                dp[i] = dp[i - 1]
            else:
                dp[i] = dp[i - 1]
                if i >= 2 and A[i - 2] == A[i - 1]:
                    dp[i] = (dp[i] + dp[i - 2]) % mod
                    if i >= 3 and A[i - 3] == A[i - 1]:
                        dp[i] = (dp[i] + dp[i - 3]) % mod
        return dp[n]