class Solution:
    def stoneGameII(self, piles: List[int]) -> int:
        n = len(piles)
        suffix_sums = [0] * (n + 1)
        for i in range(n - 1, -1, -1):
            suffix_sums[i] = suffix_sums[i + 1] + piles[i]

        dp = [[0] * (n + 1) for _ in range(n)]

        for i in range(n - 1, -1, -1):
            for m in range(1, n + 1):
                if i + 2 * m >= n:
                    dp[i][m] = suffix_sums[i]
                else:
                    for x in range(1, 2 * m + 1):
                        next_m = max(m, x)
                        if i + x < n:
                            dp[i][m] = max(dp[i][m], suffix_sums[i] - dp[i + x][next_m])

        return dp[0][1]