import math

class Solution:
    def getMinDistance(self, nums: list[int], target: int, start: int) -> int:
        min_dist = math.inf
        for i in range(len(nums)):
            if nums[i] == target:
                min_dist = min(min_dist, abs(i - start))
        return min_dist