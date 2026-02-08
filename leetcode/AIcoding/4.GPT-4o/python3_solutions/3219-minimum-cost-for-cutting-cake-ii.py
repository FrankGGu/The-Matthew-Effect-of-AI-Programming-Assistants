class Solution:
    def minCost(self, cake: List[int], k: int) -> int:
        n = len(cake)
        if n == 0:
            return 0
        if k >= n:
            return 0

        cake.sort()
        cuts = [0] + cake + [cake[-1] + 1]
        dp = [[float('inf')] * (k + 1) for _ in range(n + 2)]
        dp[0][0] = 0

        for i in range(1, n + 2):
            for j in range(1, min(k, i - 1) + 1):
                for p in range(i):
                    dp[i][j] = min(dp[i][j], dp[p][j - 1] + cuts[i] - cuts[p])

        return dp[n + 1][k]