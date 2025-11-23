from typing import List

class Solution:
    def maxBalancedSubsequence(self, nums: List[int]) -> int:
        from collections import defaultdict
        import bisect

        n = len(nums)
        pairs = [(nums[i], i) for i in range(n)]
        pairs.sort()

        index_map = {num: i for i, num in enumerate(sorted(set(nums)))}
        m = len(index_map)

        dp = [0] * m
        for i in range(n):
            num, idx = pairs[i]
            key = index_map[num]
            max_val = 0
            for j in range(key):
                if idx - pairs[j][1] >= 0:
                    max_val = max(max_val, dp[j])
            dp[key] = max(dp[key], max_val + num)

        return max(dp)