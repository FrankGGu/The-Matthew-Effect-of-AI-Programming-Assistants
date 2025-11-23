class Solution:
    def findPaths(self, m: int, n: int, maxMove: int, startRow: int, startColumn: int) -> int:
        mod = 10**9 + 7
        dp = [[[0] * (maxMove + 1) for _ in range(n)] for __ in range(m)]
        dp[startRow][startColumn][0] = 1

        for moves in range(1, maxMove + 1):
            for r in range(m):
                for c in range(n):
                    dp[r][c][moves] = (
                        (dp[r - 1][c][moves - 1] if r > 0 else 0) +
                        (dp[r + 1][c][moves - 1] if r < m - 1 else 0) +
                        (dp[r][c - 1][moves - 1] if c > 0 else 0) +
                        (dp[r][c + 1][moves - 1] if c < n - 1 else 0)
                    ) % mod

        return sum(dp[r][c][maxMove] for r in range(m) for c in range(n)) % mod