class Solution:
    def profitableSchemes(self, n: int, minProfit: int, group: List[int], profit: List[int]) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (minProfit + 1) for _ in range(n + 1)]
        dp[0][0] = 1

        for g, p in zip(group, profit):
            for i in range(n, g - 1, -1):
                for j in range(minProfit, -1, -1):
                    dp[i][min(j + p, minProfit)] += dp[i - g][j]
                    dp[i][min(j + p, minProfit)] %= MOD

        total = 0
        for i in range(n + 1):
            total += dp[i][minProfit]
            total %= MOD
        return total