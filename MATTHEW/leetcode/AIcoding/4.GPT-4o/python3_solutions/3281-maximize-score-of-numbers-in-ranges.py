class Solution:
    def maximizeScore(self, nums: List[int], multipliers: List[int]) -> int:
        n = len(nums)
        m = len(multipliers)
        dp = [[0] * (m + 1) for _ in range(m + 1)]

        for i in range(m - 1, -1, -1):
            for left in range(i + 1):
                right = n - 1 - (i - left)
                dp[left][i] = max(
                    multipliers[i] * nums[left] + dp[left + 1][i + 1] if left + 1 <= n else float('-inf'),
                    multipliers[i] * nums[right] + dp[left][i + 1] if right >= 0 else float('-inf')
                )

        return dp[0][0]