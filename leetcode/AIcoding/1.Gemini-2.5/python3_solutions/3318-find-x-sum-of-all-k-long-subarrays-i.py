from typing import List

class Solution:
    def findXSum(self, nums: List[int], k: int) -> int:
        n = len(nums)

        current_window_sum = 0
        for i in range(k):
            current_window_sum += nums[i]

        total_x_sum = current_window_sum

        for i in range(k, n):
            current_window_sum = current_window_sum - nums[i - k] + nums[i]
            total_x_sum += current_window_sum

        return total_x_sum