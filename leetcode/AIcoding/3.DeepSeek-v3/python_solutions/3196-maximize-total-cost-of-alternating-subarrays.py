class Solution:
    def maximumTotalCost(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0
        dp = [[-float('inf')] * 2 for _ in range(n)]
        dp[0][0] = nums[0]
        dp[0][1] = -nums[0]

        for i in range(1, n):
            dp[i][0] = max(dp[i-1][0] + nums[i], dp[i-1][1] - nums[i])
            dp[i][1] = max(dp[i-1][0] - nums[i], dp[i-1][1] + nums[i])

        return max(dp[-1][0], dp[-1][1])