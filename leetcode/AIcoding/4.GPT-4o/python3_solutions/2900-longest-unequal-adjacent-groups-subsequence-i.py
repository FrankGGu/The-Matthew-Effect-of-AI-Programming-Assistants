class Solution:
    def longestUnequalAdjacent(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        dp = [1] * n
        for i in range(1, n):
            if nums[i] != nums[i - 1]:
                dp[i] = dp[i - 1] + 1

        return max(dp)