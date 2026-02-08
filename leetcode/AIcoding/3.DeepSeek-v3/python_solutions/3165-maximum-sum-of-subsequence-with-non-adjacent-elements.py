class Solution:
    def maximumSumSubsequence(self, nums: List[int]) -> int:
        if not nums:
            return 0
        n = len(nums)
        if n == 1:
            return max(nums[0], 0)
        dp = [0] * n
        dp[0] = max(nums[0], 0)
        dp[1] = max(nums[0], nums[1], 0)
        for i in range(2, n):
            dp[i] = max(dp[i-1], dp[i-2] + max(nums[i], 0))
        return dp[-1]