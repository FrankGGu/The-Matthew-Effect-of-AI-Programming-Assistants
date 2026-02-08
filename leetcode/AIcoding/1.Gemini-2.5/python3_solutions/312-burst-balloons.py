from typing import List

class Solution:
    def maxCoins(self, nums: List[int]) -> int:
        n = len(nums)
        new_nums = [1] + nums + [1]

        N_padded = n + 2
        dp = [[0] * N_padded for _ in range(N_padded)]

        for length in range(2, N_padded):
            for i in range(N_padded - length):
                j = i + length

                for k in range(i + 1, j):
                    coins = dp[i][k] + new_nums[i] * new_nums[k] * new_nums[j] + dp[k][j]
                    dp[i][j] = max(dp[i][j], coins)

        return dp[0][N_padded - 1]