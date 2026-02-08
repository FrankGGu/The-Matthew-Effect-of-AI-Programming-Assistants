class Solution:
    def strangePrinter(self, s: str) -> int:
        if not s:
            return 0

        compressed_s = []
        for char in s:
            if not compressed_s or compressed_s[-1] != char:
                compressed_s.append(char)
        s = "".join(compressed_s)

        n = len(s)
        if n == 0:
            return 0

        dp = [[0] * n for _ in range(n)]

        for i in range(n):
            dp[i][i] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1

                dp[i][j] = 1 + dp[i+1][j]

                for k in range(i + 1, j + 1):
                    if s[i] == s[k]:
                        val_left = dp[i+1][k-1] if i+1 <= k-1 else 0
                        val_right = dp[k][j]
                        dp[i][j] = min(dp[i][j], val_left + val_right)

        return dp[0][n-1]