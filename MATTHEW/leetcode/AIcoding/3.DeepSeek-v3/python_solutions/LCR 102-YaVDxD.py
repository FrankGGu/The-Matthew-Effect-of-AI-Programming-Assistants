class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        total = sum(nums)
        if abs(target) > total:
            return 0
        dp = [0] * (2 * total + 1)
        dp[total] = 1
        for num in nums:
            new_dp = [0] * (2 * total + 1)
            for j in range(2 * total + 1):
                if dp[j]:
                    new_dp[j + num] += dp[j]
                    new_dp[j - num] += dp[j]
            dp = new_dp
        return dp[total + target]