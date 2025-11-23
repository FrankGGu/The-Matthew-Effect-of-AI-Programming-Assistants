import math
from collections import defaultdict

class Solution:
    def maximumSum(self, nums: list[int]) -> int:
        n = len(nums)

        square_free_sums = defaultdict(int)

        for i in range(1, n + 1):
            current_i = i

            d = 2
            while d * d <= current_i:
                if current_i % (d * d) == 0:
                    while current_i % (d * d) == 0:
                        current_i //= (d * d)
                d += 1

            square_free_part = current_i

            square_free_sums[square_free_part] += nums[i-1]

        max_total_sum = 0
        for s_sum in square_free_sums.values():
            max_total_sum = max(max_total_sum, s_sum)

        return max_total_sum