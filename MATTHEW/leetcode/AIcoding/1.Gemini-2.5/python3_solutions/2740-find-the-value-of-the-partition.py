import math

class Solution:
    def findValueOfPartition(self, nums: list[int]) -> int:
        nums.sort()

        min_diff = math.inf

        for i in range(len(nums) - 1):
            diff = nums[i+1] - nums[i]
            if diff < min_diff:
                min_diff = diff

        return min_diff