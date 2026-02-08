class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [[0] * 4 for _ in range(n + 1)]

        for i in range(1, n + 1):
            num = nums[i - 1]
            for j in range(1, 4):
                min_prev = min(dp[i-1][k] for k in range(1, j + 1))
                dp[i][j] = dp[i-1][j] if num == j else min_prev + 1

        return min(dp[n][1], dp[n][2], dp[n][3])