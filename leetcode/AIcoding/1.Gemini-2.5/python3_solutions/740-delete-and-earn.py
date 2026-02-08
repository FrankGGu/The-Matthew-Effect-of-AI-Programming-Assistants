from typing import List

class Solution:
    def deleteAndEarn(self, nums: List[int]) -> int:
        if not nums:
            return 0

        # Find the maximum number in nums to determine the size of our points array
        max_val = 0
        for num in nums:
            max_val = max(max_val, num)

        # Create a points array where points[i] stores the total points
        # earned if we choose to take number i. This is the sum of all
        # occurrences of i in the original nums array.
        points = [0] * (max_val + 1)
        for num in nums:
            points[num] += num

        # dp[i] represents the maximum points that can be earned considering
        # numbers up to i. This is a classic House Robber problem variation.
        dp = [0] * (max_val + 1)

        # Base cases for the DP
        # dp[0] is 0 because numbers in nums are >= 1, so points[0] is always 0.
        # dp[1] is points[1] because if we only consider number 1, we can take it.

        # max_val will be at least 1 due to problem constraints (1 <= nums[i] <= 10000)
        dp[0] = 0 
        if max_val >= 1:
            dp[1] = points[1]

        # Fill the dp array using the recurrence relation:
        # dp[i] = max(dp[i-1], dp[i-2] + points[i])
        # This means, for number i:
        # 1. We don't take i: The maximum points are the same as considering up to i-1 (dp[i-1]).
        # 2. We take i: We get points[i] and cannot take i-1. So, we add points[i] to
        #    the maximum points earned considering numbers up to i-2 (dp[i-2]).
        for i in range(2, max_val + 1):
            dp[i] = max(dp[i-1], dp[i-2] + points[i])

        return dp[max_val]