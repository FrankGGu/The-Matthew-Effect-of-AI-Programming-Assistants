class Solution:
    def dieSimulator(self, n: int, rollMax: List[int]) -> int:
        MOD = 10**9 + 7
        dp = [[[0] * (max(rollMax) + 1) for _ in range(6)] for __ in range(n + 1)]

        for j in range(6):
            dp[1][j][1] = 1

        for i in range(2, n + 1):
            for j in range(6):
                for k in range(1, rollMax[j] + 1):
                    if k == 1:
                        for prev_j in range(6):
                            if prev_j != j:
                                for prev_k in range(1, rollMax[prev_j] + 1):
                                    dp[i][j][k] += dp[i-1][prev_j][prev_k]
                                    dp[i][j][k] %= MOD
                    else:
                        dp[i][j][k] = dp[i-1][j][k-1]
                        dp[i][j][k] %= MOD

        total = 0
        for j in range(6):
            for k in range(1, rollMax[j] + 1):
                total += dp[n][j][k]
                total %= MOD
        return total