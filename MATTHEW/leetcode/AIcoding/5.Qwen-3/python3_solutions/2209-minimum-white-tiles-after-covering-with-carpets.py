class Solution:
    def minimumWhiteTiles(self, carpet: str, carpetLen: int) -> int:
        n = len(carpet)
        dp = [0] * (n + 1)
        for i in range(n):
            dp[i + 1] = dp[i] + (1 if carpet[i] == 'w' else 0)
        for i in range(n):
            if i + carpetLen <= n:
                dp[i + carpetLen] = min(dp[i + carpetLen], dp[i])
        return dp[n]