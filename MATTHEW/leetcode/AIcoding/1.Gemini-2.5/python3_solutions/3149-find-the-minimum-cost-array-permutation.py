import math

class Solution:
    def minimumCostArrayPermutation(self, nums: list[int]) -> int:
        n = len(nums)

        dp = [math.inf] * (1 << n)

        dp[0] = 0

        for mask in range(1 << n):
            if dp[mask] == math.inf:
                continue

            i = bin(mask).count('1')

            if i == n:
                continue

            for j in range(n):
                if not (mask & (1 << j)):
                    new_mask = mask | (1 << j)
                    cost_to_add = nums[j] ^ i
                    dp[new_mask] = min(dp[new_mask], dp[mask] + cost_to_add)

        return dp[(1 << n) - 1]