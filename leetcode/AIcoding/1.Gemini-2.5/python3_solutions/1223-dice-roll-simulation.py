class Solution:
    def diceRollsSimulation(self, n: int, rollMax: list[int]) -> int:
        MOD = 10**9 + 7

        dp = [[0] * 6 for _ in range(n + 1)]
        S = [0] * (n + 1)

        S[0] = 1 

        for j in range(6):
            dp[1][j] = 1
        S[1] = 6

        for i in range(2, n + 1):
            for j in range(6):
                dp[i][j] = S[i-1]

                if i - 1 >= rollMax[j]:
                    invalid_prefix_count = (S[i - 1 - rollMax[j]] - dp[i - 1 - rollMax[j]][j] + MOD) % MOD
                    dp[i][j] = (dp[i][j] - invalid_prefix_count + MOD) % MOD

            S[i] = sum(dp[i][j] for j in range(6)) % MOD

        return S[n]