from typing import List

class Solution:
    def isIdealPermutation(self, nums: List[int]) -> bool:
        n = len(nums)

        if n < 3:
            return True

        min_val_after_i_plus_one = nums[n - 1]

        for i in range(n - 3, -1, -1):
            if nums[i] > min_val_after_i_plus_one:
                return False
            min_val_after_i_plus_one = min(min_val_after_i_plus_one, nums[i + 1])

        return True