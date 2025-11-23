class Solution:
    def maximumScore(self, nums: List[int], multipliers: List[int]) -> int:
        n = len(nums)
        m = len(multipliers)
        dp = [[0] * (m + 1) for _ in range(m + 1)]

        for i in range(1, m + 1):
            for j in range(i + 1):
                left_index = j
                right_index = n - (i - j)
                if left_index < n:
                    dp[i][j] = max(dp[i][j], dp[i - 1][j] + multipliers[i - 1] * nums[left_index])
                if right_index >= 0:
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + multipliers[i - 1] * nums[right_index])

        return max(dp[m])