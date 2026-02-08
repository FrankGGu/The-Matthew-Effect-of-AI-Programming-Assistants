class Solution:
    def minSpaceWastedKResizing(self, nums: list[int], k: int) -> int:
        n = len(nums)
        dp = [[float('inf')] * (k + 2) for _ in range(n + 1)]
        dp[0][0] = 0
        prefix_max = [[0] * (n + 1) for _ in range(n + 1)]
        prefix_sum = [[0] * (n + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            prefix_max[i][i] = nums[i - 1]
            prefix_sum[i][i] = nums[i - 1]
            for j in range(i + 1, n + 1):
                prefix_max[i][j] = max(prefix_max[i][j - 1], nums[j - 1])
                prefix_sum[i][j] = prefix_sum[i][j - 1] + nums[j - 1]

        for i in range(1, n + 1):
            for j in range(0, min(i, k + 1) + 1):
                if j == 0:
                    dp[i][j] = prefix_max[1][i] * i - prefix_sum[1][i]
                else:
                    for l in range(1, i + 1):
                        dp[i][j] = min(dp[i][j], dp[l - 1][j - 1] + prefix_max[l][i] * (i - l + 1) - prefix_sum[l][i])

        return dp[n][k + 1]