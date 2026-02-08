from typing import List

class Solution:
    def getAverages(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        averages = [-1] * n

        if k == 0:
            return nums

        window_size = 2 * k + 1

        if window_size > n:
            return averages

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        for i in range(n):
            left_bound = i - k
            right_bound = i + k

            if left_bound >= 0 and right_bound < n:
                current_sum = prefix_sum[right_bound + 1] - prefix_sum[left_bound]
                averages[i] = current_sum // window_size

        return averages