class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [[0] * 4 for _ in range(n + 1)]
        for i in range(1, n + 1):
            for j in range(1, 4):
                dp[i][j] = dp[i - 1][j]
                if nums[i - 1] == j:
                    dp[i][j] += 1

        ans = 0
        for i in range(1, n + 1):
            for j in range(1, 4):
                dp[i][j] = max(dp[i][j], dp[i][j-1])
            ans = max(ans, dp[i][3])

        return n - ans