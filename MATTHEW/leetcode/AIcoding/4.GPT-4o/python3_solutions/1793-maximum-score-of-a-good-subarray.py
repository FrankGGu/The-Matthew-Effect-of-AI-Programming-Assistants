class Solution:
    def maximumScore(self, nums: List[int], multipliers: List[int]) -> int:
        n, m = len(nums), len(multipliers)
        dp = [[0] * (m + 1) for _ in range(m + 1)]

        for i in range(1, m + 1):
            for j in range(i + 1):
                left = dp[i - 1][j] + nums[j] * multipliers[i - 1] if j < n else float('-inf')
                right = dp[i - 1][j - 1] + nums[n - 1 - (i - j)] * multipliers[i - 1] if j > 0 else float('-inf')
                dp[i][j] = max(left, right)

        return max(dp[m])