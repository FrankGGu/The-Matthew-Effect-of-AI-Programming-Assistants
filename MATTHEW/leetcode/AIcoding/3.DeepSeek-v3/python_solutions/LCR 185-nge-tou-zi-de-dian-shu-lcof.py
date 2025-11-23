class Solution:
    def dicesProbability(self, n: int) -> List[float]:
        dp = [ [0] * (6 * n + 1) for _ in range(n + 1) ]
        for j in range(1, 7):
            dp[1][j] = 1

        for i in range(2, n + 1):
            for j in range(i, 6 * i + 1):
                for k in range(1, 7):
                    if j - k >= 0:
                        dp[i][j] += dp[i - 1][j - k]

        total = 6 ** n
        res = []
        for j in range(n, 6 * n + 1):
            res.append(dp[n][j] / total)
        return res