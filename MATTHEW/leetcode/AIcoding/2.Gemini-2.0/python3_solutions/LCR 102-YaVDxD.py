class Solution:
    def findTargetSumWays(self, nums: list[int], target: int) -> int:
        n = len(nums)
        total_sum = sum(nums)
        if (total_sum + target) % 2 != 0:
            return 0
        sum_target = (total_sum + target) // 2
        if sum_target < 0:
            return 0

        dp = [0] * (sum_target + 1)
        dp[0] = 1

        for num in nums:
            for i in range(sum_target, num - 1, -1):
                dp[i] += dp[i - num]

        return dp[sum_target]