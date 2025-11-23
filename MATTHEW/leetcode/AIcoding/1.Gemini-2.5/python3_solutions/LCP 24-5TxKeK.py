from typing import List

class Solution:
    def arrayPairSum(self, nums: List[int]) -> int:
        nums.sort()
        total_sum = 0
        for i in range(0, len(nums), 2):
            total_sum += nums[i]
        return total_sum