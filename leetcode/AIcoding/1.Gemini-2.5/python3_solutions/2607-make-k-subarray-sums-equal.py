from typing import List

class Solution:
    def makeKSubarraySumsEqual(self, nums: List[int], k: int) -> int:
        n = len(nums)
        total_operations = 0

        for start_idx in range(k):
            current_group_elements = []

            idx = start_idx
            while idx < n:
                current_group_elements.append(nums[idx])
                idx += k

            current_group_elements.sort()

            median = current_group_elements[len(current_group_elements) // 2]

            for val in current_group_elements:
                total_operations += abs(val - median)

        return total_operations