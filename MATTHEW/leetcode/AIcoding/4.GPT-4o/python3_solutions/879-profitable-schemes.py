class Solution:
    def profitableSchemes(self, G: int, P: int, group: List[int], profit: List[int]) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (P + 1) for _ in range(G + 1)]
        dp[0][0] = 1

        for i in range(len(group)):
            g, p = group[i], profit[i]
            for j in range(G, g - 1, -1):
                for k in range(P, -1, -1):
                    dp[j][min(P, k + p)] = (dp[j][min(P, k + p)] + dp[j - g][k]) % MOD

        return sum(dp[j][P] for j in range(G + 1)) % MOD