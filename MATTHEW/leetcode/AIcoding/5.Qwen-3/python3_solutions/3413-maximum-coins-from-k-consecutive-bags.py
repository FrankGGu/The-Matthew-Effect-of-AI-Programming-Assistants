from typing import List

class Solution:
    def maxCoins(self, nums: List[int]) -> int:
        n = len(nums)
        nums = [0] + nums + [0]
        dp = [[0] * (n + 2) for _ in range(n + 2)]

        for length in range(1, n + 1):
            for i in range(1, n - length + 2):
                j = i + length - 1
                for k in range(i, j + 1):
                    coins = nums[i - 1] * nums[k] * nums[j + 1]
                    coins += dp[i][k - 1] + dp[k + 1][j]
                    dp[i][j] = max(dp[i][j], coins)
        return dp[1][n]