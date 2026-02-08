class Solution:
    def maxCoins(self, bags: List[List[int]], k: int) -> int:
        bags.sort()
        n = len(bags)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + bags[i][1]

        dp = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                dp[i][j] = dp[i-1][j]
                for l in range(i):
                    if bags[i-1][0] - bags[l][0] <= 1:
                        dp[i][j] = max(dp[i][j], dp[l][j-1] + prefix[i] - prefix[l])
                    else:
                        break
        return dp[n][k]