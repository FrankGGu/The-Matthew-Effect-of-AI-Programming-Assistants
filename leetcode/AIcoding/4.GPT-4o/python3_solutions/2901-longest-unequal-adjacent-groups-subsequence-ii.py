class Solution:
    def longestUnequalAdjacentGroups(self, nums: List[int]) -> int:
        n = len(nums)
        if n < 3:
            return n

        dp = [1] * n
        for i in range(1, n):
            if nums[i] != nums[i - 1]:
                dp[i] = dp[i - 1] + 1

        max_length = max(dp)
        for i in range(1, n - 1):
            if nums[i] != nums[i - 1] and nums[i] != nums[i + 1]:
                max_length = max(max_length, dp[i - 1] + 1 + dp[i + 1] - 1)

        return max_length