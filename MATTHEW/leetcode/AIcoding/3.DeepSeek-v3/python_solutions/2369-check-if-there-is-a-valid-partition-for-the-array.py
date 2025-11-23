class Solution:
    def validPartition(self, nums: List[int]) -> bool:
        n = len(nums)
        dp = [False] * (n + 1)
        dp[0] = True

        for i in range(1, n + 1):
            if i >= 2 and nums[i-2] == nums[i-1]:
                dp[i] = dp[i] or dp[i-2]
            if i >= 3:
                if (nums[i-3] == nums[i-2] == nums[i-1]) or (nums[i-3] + 1 == nums[i-2] and nums[i-2] + 1 == nums[i-1]):
                    dp[i] = dp[i] or dp[i-3]

        return dp[n]