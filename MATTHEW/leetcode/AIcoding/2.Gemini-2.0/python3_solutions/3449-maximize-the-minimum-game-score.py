class Solution:
    def maximizeTheMinimumGameScore(self, nums: list[int], k: int) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        dp = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            dp[i][1] = prefix_sum[i]

        for j in range(2, k + 1):
            for i in range(j, n + 1):
                dp[i][j] = float('inf')
                for x in range(j - 1, i):
                    dp[i][j] = min(dp[i][j], max(dp[x][j - 1], prefix_sum[i] - prefix_sum[x]))

        return dp[n][k]