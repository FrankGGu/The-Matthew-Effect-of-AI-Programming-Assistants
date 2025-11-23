class Solution:
    def ways(self, pizza: List[str], k: int) -> int:
        MOD = 10**9 + 7
        rows = len(pizza)
        cols = len(pizza[0])

        # Precompute the number of apples in the submatrix from (i, j) to (rows-1, cols-1)
        apples = [[0] * (cols + 1) for _ in range(rows + 1)]
        for i in range(rows - 1, -1, -1):
            for j in range(cols - 1, -1, -1):
                apples[i][j] = apples[i + 1][j] + apples[i][j + 1] - apples[i + 1][j + 1] + (1 if pizza[i][j] == 'A' else 0)

        # Memoization table: dp[m][i][j] = number of ways to cut pizza[i:][j:] into m pieces
        dp = [[[0] * cols for _ in range(rows)] for __ in range(k + 1)]

        for i in range(rows):
            for j in range(cols):
                if apples[i][j] > 0:
                    dp[1][i][j] = 1

        for m in range(2, k + 1):
            for i in range(rows):
                for j in range(cols):
                    if apples[i][j] < m:
                        continue
                    # Try all possible horizontal cuts
                    total = 0
                    for x in range(i + 1, rows):
                        if apples[i][j] - apples[x][j] > 0:
                            total += dp[m - 1][x][j]
                            total %= MOD
                    # Try all possible vertical cuts
                    for y in range(j + 1, cols):
                        if apples[i][j] - apples[i][y] > 0:
                            total += dp[m - 1][i][y]
                            total %= MOD
                    dp[m][i][j] = total

        return dp[k][0][0] % MOD