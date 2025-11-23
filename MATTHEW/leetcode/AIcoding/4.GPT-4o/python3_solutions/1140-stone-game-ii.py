class Solution:
    def stoneGameII(self, piles: List[int]) -> int:
        n = len(piles)
        dp = [[0] * (n + 1) for _ in range(n + 1)]
        suffix_sum = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            suffix_sum[i] = suffix_sum[i + 1] + piles[i]

        for i in range(n - 1, -1, -1):
            for m in range(1, n + 1):
                max_stones = 0
                for x in range(1, 2 * m + 1):
                    if i + x <= n:
                        max_stones = max(max_stones, suffix_sum[i] - dp[i + x][max(m, x)])
                dp[i][m] = max_stones

        return dp[0][1]