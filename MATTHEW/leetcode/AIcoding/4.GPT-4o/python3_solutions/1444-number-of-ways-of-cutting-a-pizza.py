class Solution:
    def waysToCutPizza(self, pizza: List[str], k: int) -> int:
        m, n = len(pizza), len(pizza[0])
        mod = 10**9 + 7

        prefix = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                prefix[i][j] = prefix[i + 1][j] + prefix[i][j + 1] - prefix[i + 1][j + 1] + (pizza[i][j] == 'A')

        dp = [[[0] * (k + 1) for _ in range(n)] for _ in range(m)]

        for x in range(m):
            for y in range(n):
                if prefix[x][y] > 0:
                    dp[x][y][1] = 1

        for cuts in range(2, k + 1):
            for x in range(m):
                for y in range(n):
                    for i in range(x + 1, m):
                        if prefix[x][y] - prefix[i][y] > 0:
                            dp[x][y][cuts] = (dp[x][y][cuts] + dp[i][y][cuts - 1]) % mod
                    for j in range(y + 1, n):
                        if prefix[x][y] - prefix[x][j] > 0:
                            dp[x][y][cuts] = (dp[x][y][cuts] + dp[x][j][cuts - 1]) % mod

        return dp[0][0][k]