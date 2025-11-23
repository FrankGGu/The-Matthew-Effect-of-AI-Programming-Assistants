class Solution:
    def minimumWhiteTiles(self, floor: str, numCarpets: int, carpetLen: int) -> int:
        n = len(floor)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + (1 if floor[i] == '1' else 0)

        dp = [[0] * (n + 1) for _ in range(numCarpets + 1)]

        for k in range(1, numCarpets + 1):
            for i in range(1, n + 1):
                if i <= carpetLen:
                    dp[k][i] = 0
                else:
                    dp[k][i] = min(dp[k][i-1] + (1 if floor[i-1] == '1' else 0), dp[k-1][i - carpetLen])

        return dp[numCarpets][n]