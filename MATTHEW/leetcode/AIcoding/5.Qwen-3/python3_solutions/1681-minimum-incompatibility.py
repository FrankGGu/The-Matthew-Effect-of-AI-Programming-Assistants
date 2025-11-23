from typing import List
from collections import deque

class Solution:
    def minIncompatibility(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if k == n:
            return 0
        if k == 1:
            return sum(nums)

        nums.sort()
        incompatibility = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(i + 1, n):
                incompatibility[i][j] = nums[j] - nums[i]

        dp = [float('inf')] * (1 << n)
        dp[0] = 0

        for mask in range(1 << n):
            if dp[mask] == float('inf'):
                continue
            count = bin(mask).count('1')
            if count % k == 0:
                continue
            for i in range(n):
                if not (mask & (1 << i)):
                    new_mask = mask | (1 << i)
                    if dp[new_mask] > dp[mask] + incompatibility[i][i]:
                        dp[new_mask] = dp[mask] + incompatibility[i][i]
                    for j in range(i + 1, n):
                        if not (mask & (1 << j)):
                            new_mask2 = new_mask | (1 << j)
                            if dp[new_mask2] > dp[mask] + incompatibility[i][j]:
                                dp[new_mask2] = dp[mask] + incompatibility[i][j]

        return dp[(1 << n) - 1] if dp[(1 << n) - 1] != float('inf') else -1