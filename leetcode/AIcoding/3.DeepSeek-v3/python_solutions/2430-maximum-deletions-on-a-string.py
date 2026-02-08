class Solution:
    def deleteString(self, s: str) -> int:
        n = len(s)
        dp = [1] * n
        for i in range(n - 1, -1, -1):
            for j in range(1, (n - i) // 2 + 1):
                if s[i:i+j] == s[i+j:i+2*j]:
                    if i + 2*j <= n:
                        dp[i] = max(dp[i], dp[i + j] + 1)
        return dp[0]