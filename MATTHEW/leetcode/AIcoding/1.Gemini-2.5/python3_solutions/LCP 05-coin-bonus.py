from collections import Counter

class Solution:
    def deleteAndEarn(self, nums: list[int]) -> int:
        if not nums:
            return 0

        max_val = 0
        for num in nums:
            max_val = max(max_val, num)

        points = [0] * (max_val + 1)
        counts = Counter(nums)

        for num, count in counts.items():
            points[num] = num * count

        dp = [0] * (max_val + 1)

        dp[0] = 0
        if max_val >= 1:
            dp[1] = points[1]

        for i in range(2, max_val + 1):
            dp[i] = max(dp[i-1], dp[i-2] + points[i])

        return dp[max_val]