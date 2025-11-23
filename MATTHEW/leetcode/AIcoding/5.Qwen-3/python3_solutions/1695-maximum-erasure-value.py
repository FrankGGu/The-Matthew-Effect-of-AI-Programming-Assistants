class Solution:
    def maximumErasureValue(self, nums: List[int]) -> int:
        from collections import defaultdict

        left = 0
        max_sum = 0
        current_sum = 0
        last_occurrence = {}

        for right in range(len(nums)):
            if nums[right] in last_occurrence:
                left = max(left, last_occurrence[nums[right]] + 1)
            last_occurrence[nums[right]] = right
            current_sum += nums[right]
            max_sum = max(max_sum, current_sum)

        return max_sum