class Solution:
    def minCost(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if n == 0: return 0
        if k >= n: return 0

        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                if i - j >= 0:
                    dp[i] = min(dp[i], dp[i - j] + sum(nums[i - j:i]))

        return dp[n]