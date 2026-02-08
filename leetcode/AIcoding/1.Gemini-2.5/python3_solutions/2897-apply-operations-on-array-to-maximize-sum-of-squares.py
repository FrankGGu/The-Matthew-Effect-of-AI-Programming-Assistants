import heapq
import math

class Solution:
    def maxSumSquares(self, nums: list[int], k: int) -> int:
        MOD = 10**9 + 7

        heapq.heapify(nums)

        for _ in range(k):
            x = heapq.heappop(nums)

            # Calculate ceil(x / 3) for positive integers
            # (x + 2) // 3 is equivalent to math.ceil(x / 3)
            new_x = (x + 2) // 3

            heapq.heappush(nums, new_x)

        total_sum_sq = 0
        for x in nums:
            total_sum_sq = (total_sum_sq + x * x) % MOD

        return total_sum_sq