from typing import List

class Solution:
    def dominantIndex(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return 0

        max_val = -1
        max_idx = -1
        second_max_val = -1

        for i, num in enumerate(nums):
            if num > max_val:
                second_max_val = max_val
                max_val = num
                max_idx = i
            elif num > second_max_val:
                second_max_val = num

        if max_val >= 2 * second_max_val:
            return max_idx
        else:
            return -1