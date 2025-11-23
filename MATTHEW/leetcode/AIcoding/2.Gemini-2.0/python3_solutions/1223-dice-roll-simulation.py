class Solution:
    def dieSimulator(self, n: int, rollMax: list[int]) -> int:
        mod = 10**9 + 7
        dp = [[[0] * 16 for _ in range(6)] for _ in range(n + 1)]
        total = [0] * (n + 1)
        total[0] = 1

        for i in range(6):
            dp[1][i][1] = 1
        total[1] = 6

        for i in range(2, n + 1):
            for j in range(6):
                for k in range(1, rollMax[j] + 1):
                    if i - k >= 0:
                        if k == 1:
                            dp[i][j][k] = (total[i - 1] - sum(dp[i - 1][l][m] for l in range(6) for m in range(1, rollMax[l] + 1) if l != j)) % mod
                        else:
                            dp[i][j][k] = dp[i - 1][j][k - 1]
                    dp[i][j][k] %= mod

            total[i] = sum(dp[i][l][m] for l in range(6) for m in range(1, rollMax[l] + 1)) % mod

        return total[n]