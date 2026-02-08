import math

class Solution:
    def minimumSum(self, nums: list[int]) -> int:
        n = len(nums)
        min_sum = math.inf

        for j in range(1, n - 1):
            for i in range(j):
                for k in range(j + 1, n):
                    if nums[i] < nums[j] and nums[k] < nums[j]:
                        current_sum = nums[i] + nums[j] + nums[k]
                        min_sum = min(min_sum, current_sum)

        if min_sum == math.inf:
            return -1
        else:
            return min_sum