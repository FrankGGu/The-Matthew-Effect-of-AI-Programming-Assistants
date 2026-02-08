class Solution:
    def findTargetSumWays(self, nums: list[int], target: int) -> int:
        total_sum = sum(nums)

        if (total_sum + target) % 2 != 0 or abs(target) > total_sum:
            return 0

        s = (total_sum + target) // 2

        dp = [0] * (s + 1)
        dp[0] = 1 

        for num in nums:
            for j in range(s, num - 1, -1):
                dp[j] += dp[j - num]

        return dp[s]