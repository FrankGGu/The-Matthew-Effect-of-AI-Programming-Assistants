import math
from typing import List

class Solution:
    def maximumValueSum(self, nums: List[int], k: int, edges: List[List[int]]) -> int:
        total_sum = 0
        count_flipped = 0
        min_diff_abs = math.inf

        for num in nums:
            flipped_num = num ^ k
            diff = flipped_num - num

            total_sum += num

            if diff > 0:
                total_sum += diff
                count_flipped += 1

            min_diff_abs = min(min_diff_abs, abs(diff))

        if count_flipped % 2 == 0:
            return total_sum
        else:
            return total_sum - min_diff_abs