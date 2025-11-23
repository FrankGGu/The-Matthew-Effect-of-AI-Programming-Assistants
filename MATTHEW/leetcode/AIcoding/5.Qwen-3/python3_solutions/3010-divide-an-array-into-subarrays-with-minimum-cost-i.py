from typing import List

class Solution:
    def minCostToSplit(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            unique = set()
            for j in range(i - 1, max(-1, i - k - 1), -1):
                unique.add(nums[j])
                dp[i] = min(dp[i], dp[j] + len(unique))

        return dp[n]