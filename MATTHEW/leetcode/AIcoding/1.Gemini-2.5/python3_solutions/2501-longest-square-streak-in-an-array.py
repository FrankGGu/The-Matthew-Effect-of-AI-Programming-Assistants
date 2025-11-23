import math

class Solution:
    def longestSquareStreak(self, nums: list[int]) -> int:
        num_set = set(nums)

        unique_nums = sorted(list(num_set))

        dp = {}
        max_streak = 1

        for x in unique_nums:
            sqrt_x = int(math.sqrt(x))

            if sqrt_x * sqrt_x == x and sqrt_x in num_set and sqrt_x != x:
                dp[x] = dp[sqrt_x] + 1
            else:
                dp[x] = 1

            max_streak = max(max_streak, dp[x])

        if max_streak == 1:
            return -1
        else:
            return max_streak