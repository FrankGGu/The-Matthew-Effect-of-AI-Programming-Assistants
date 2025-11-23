import math

class Solution:
    def minimumSum(self, nums: list[int]) -> int:
        n = len(nums)

        left_min = [0] * n
        right_min = [0] * n

        left_min[0] = nums[0]
        for i in range(1, n):
            left_min[i] = min(left_min[i-1], nums[i])

        right_min[n-1] = nums[n-1]
        for i in range(n - 2, -1, -1):
            right_min[i] = min(right_min[i+1], nums[i])

        min_total_sum = math.inf

        for j in range(1, n - 1):
            # left_min[j-1] stores the minimum value among nums[0]...nums[j-1]
            # right_min[j+1] stores the minimum value among nums[j+1]...nums[n-1]

            if left_min[j-1] < nums[j] and right_min[j+1] < nums[j]:
                current_sum = left_min[j-1] + nums[j] + right_min[j+1]
                min_total_sum = min(min_total_sum, current_sum)

        if min_total_sum == math.inf:
            return -1
        else:
            return min_total_sum