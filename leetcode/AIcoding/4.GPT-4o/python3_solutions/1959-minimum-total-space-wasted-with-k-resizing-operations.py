class Solution:
    def minSpaceWastedKResizing(self, heights: List[int], k: int) -> int:
        n = len(heights)
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(k + 1):
                max_height = 0
                total_waste = 0
                for m in range(i, 0, -1):
                    max_height = max(max_height, heights[m - 1])
                    total_waste += max_height - heights[m - 1]
                    if j == 0 and m == i:
                        dp[i][j] = min(dp[i][j], total_waste)
                    elif j > 0:
                        dp[i][j] = min(dp[i][j], dp[m - 1][j - 1] + total_waste)

        return dp[n][k]