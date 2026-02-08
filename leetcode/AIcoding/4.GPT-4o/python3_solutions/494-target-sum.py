class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        total_sum = sum(nums)
        if total_sum < target or (total_sum + target) % 2 != 0:
            return 0
        new_target = (total_sum + target) // 2
        dp = [0] * (new_target + 1)
        dp[0] = 1

        for num in nums:
            for j in range(new_target, num - 1, -1):
                dp[j] += dp[j - num]

        return dp[new_target]