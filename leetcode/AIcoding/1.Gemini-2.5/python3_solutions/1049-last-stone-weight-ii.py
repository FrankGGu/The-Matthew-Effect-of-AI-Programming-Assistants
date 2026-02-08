import math

class Solution:
    def lastStoneWeightII(self, stones: list[int]) -> int:
        total_sum = sum(stones)
        target_sum_half = total_sum // 2

        dp = [False] * (target_sum_half + 1)
        dp[0] = True

        for stone_weight in stones:
            for current_sum in range(target_sum_half, stone_weight - 1, -1):
                dp[current_sum] = dp[current_sum] or dp[current_sum - stone_weight]

        max_s1 = 0
        for s1 in range(target_sum_half, -1, -1):
            if dp[s1]:
                max_s1 = s1
                break

        return total_sum - 2 * max_s1