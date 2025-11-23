class Solution:
    def profitableSchemes(self, n: int, minProfit: int, group: list[int], profit: list[int]) -> int:
        MOD = 10**9 + 7
        dp = [[[0] * (n + 1) for _ in range(minProfit + 1)] for _ in range(len(group) + 1)]
        dp[0][0][0] = 1
        for i in range(1, len(group) + 1):
            g = group[i - 1]
            p = profit[i - 1]
            for j in range(minProfit + 1):
                for k in range(n + 1):
                    dp[i][j][k] = dp[i - 1][j][k]
                    if k >= g:
                        dp[i][j][k] = (dp[i][j][k] + dp[i - 1][max(0, j - p)][k - g]) % MOD
        ans = 0
        for k in range(n + 1):
            ans = (ans + dp[len(group)][minProfit][k]) % MOD
        return ans