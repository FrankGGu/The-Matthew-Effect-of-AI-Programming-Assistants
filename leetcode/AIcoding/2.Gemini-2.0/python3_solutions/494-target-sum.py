class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        total_sum = sum(nums)
        if (total_sum + target) % 2 != 0:
            return 0

        sum_positive = (total_sum + target) // 2

        if sum_positive < 0:
            return 0

        dp = [0] * (sum_positive + 1)
        dp[0] = 1

        for num in nums:
            for i in range(sum_positive, num - 1, -1):
                dp[i] += dp[i - num]

        return dp[sum_positive]