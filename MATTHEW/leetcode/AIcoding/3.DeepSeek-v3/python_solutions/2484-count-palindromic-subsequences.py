class Solution:
    def countPalindromes(self, s: str) -> int:
        mod = 10**9 + 7
        n = len(s)
        dp = [[[0] * 10 for _ in range(10)] for __ in range(n)]
        count = [[0] * 10 for _ in range(n)]

        for i in range(n):
            c = ord(s[i]) - ord('0')
            for j in range(10):
                for k in range(10):
                    if i > 0:
                        dp[i][j][k] = dp[i-1][j][k]
                        if k == c:
                            dp[i][j][k] += count[i-1][j]
                            dp[i][j][k] %= mod
            if i > 0:
                for j in range(10):
                    count[i][j] = count[i-1][j]
            count[i][c] += 1

        total = 0
        for i in range(n):
            c = ord(s[i]) - ord('0')
            for j in range(10):
                for k in range(10):
                    if i < n - 1:
                        total += dp[i][j][k] * (count[n-1][k] - count[i][k])
                        total %= mod

        return total