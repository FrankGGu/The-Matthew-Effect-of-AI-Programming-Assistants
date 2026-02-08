class Solution:
    def maxScore(self, nums: List[int], multipliers: List[int]) -> int:
        n = len(nums)
        m = len(multipliers)
        dp = [[0] * (m + 1) for _ in range(m + 1)]

        for i in range(m - 1, -1, -1):
            for left in range(i, -1, -1):
                right = n - 1 - (i - left)
                option1 = nums[left] * multipliers[i] + dp[i + 1][left + 1]
                option2 = nums[right] * multipliers[i] + dp[i + 1][left]
                dp[i][left] = max(option1, option2)

        return dp[0][0]