class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        total_sum = sum(nums)

        if (target + total_sum) % 2 != 0 or (target + total_sum) < 0:
            return 0

        s_target = (target + total_sum) // 2

        dp = [0] * (s_target + 1)
        dp[0] = 1

        for num in nums:
            for j in range(s_target, num - 1, -1):
                dp[j] += dp[j - num]

        return dp[s_target]