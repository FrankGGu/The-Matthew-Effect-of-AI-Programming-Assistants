from typing import List

class Solution:
    def longestArithSeqLength(self, nums: List[int]) -> int:
        n = len(nums)
        if n <= 2:
            return n
        dp = [{} for _ in range(n)]
        max_len = 2
        for i in range(n):
            for j in range(i):
                diff = nums[i] - nums[j]
                dp[i][diff] = dp[j].get(diff, 1) + 1
                max_len = max(max_len, dp[i][diff])
        return max_len