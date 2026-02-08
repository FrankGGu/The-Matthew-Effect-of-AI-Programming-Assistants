class Solution:
    def findTargetSumWays(self, nums: list[int], target: int) -> int:
        total_sum = sum(nums)

        if (target + total_sum) % 2 != 0 or total_sum < abs(target):
            return 0

        s_prime = (target + total_sum) // 2

        if s_prime < 0:
            return 0

        dp = [0] * (s_prime + 1)
        dp[0] = 1

        for num in nums:
            for s in range(s_prime, num - 1, -1):
                dp[s] += dp[s - num]

        return dp[s_prime]