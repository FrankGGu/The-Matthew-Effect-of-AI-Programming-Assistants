class Solution:
    def countPartitions(self, nums: list[int], k: int) -> int:
        total_sum = sum(nums)

        if (total_sum + k) % 2 != 0:
            return 0

        target_sum = (total_sum + k) // 2

        if target_sum < 0 or target_sum > total_sum:
            return 0

        dp = [0] * (target_sum + 1)
        dp[0] = 1

        MOD = 10**9 + 7

        for num in nums:
            for j in range(target_sum, num - 1, -1):
                dp[j] = (dp[j] + dp[j - num]) % MOD

        return dp[target_sum]