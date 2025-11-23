from typing import List

class Solution:
    def countNonDecreasingSubarraysAfterKOperations(self, nums: List[int], k: int) -> int:
        n = len(nums)
        total_count = 0
        left = 0
        current_violations = 0

        for right in range(n):
            if right > 0 and nums[right - 1] > nums[right]:
                current_violations += 1

            while current_violations > k:
                if nums[left] > nums[left + 1]:
                    current_violations -= 1
                left += 1

            total_count += (right - left + 1)

        return total_count