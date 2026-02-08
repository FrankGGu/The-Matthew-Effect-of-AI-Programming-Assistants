class Solution:
    def maximumScore(self, nums: List[int], multipliers: List[int]) -> int:
        n = len(nums)
        m = len(multipliers)
        dp = [[-float('inf')] * (m + 1) for _ in range(m + 1)]
        dp[0][0] = 0

        for i in range(1, m + 1):
            for j in range(i + 1):
                k = i - j
                if j > 0:
                    dp[j][i] = max(dp[j][i], dp[j - 1][i - 1] + nums[j - 1] * multipliers[i - 1])
                if k > 0:
                    dp[j][i] = max(dp[j][i], dp[j][i - 1] + nums[n - k] * multipliers[i - 1])

        return max(dp[j][m] for j in range(m + 1))