from typing import List

class Solution:
    def maximumUniqueSubarray(self, nums: List[int]) -> int:
        from collections import defaultdict

        max_sum = 0
        left = 0
        current_sum = 0
        seen = defaultdict(int)

        for right in range(len(nums)):
            while seen[nums[right]] > 0:
                seen[nums[left]] -= 1
                current_sum -= nums[left]
                left += 1
            seen[nums[right]] += 1
            current_sum += nums[right]
            max_sum = max(max_sum, current_sum)

        return max_sum