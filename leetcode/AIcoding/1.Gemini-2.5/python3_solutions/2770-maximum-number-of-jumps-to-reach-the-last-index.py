class Solution:
    def maxJumps(self, nums: list[int], target: int) -> int:
        n = len(nums)
        dp = [-1] * n
        dp[0] = 0

        for j in range(1, n):
            for i in range(j):
                if dp[i] != -1 and abs(nums[i] - nums[j]) <= target:
                    dp[j] = max(dp[j], dp[i] + 1)

        return dp[n - 1]