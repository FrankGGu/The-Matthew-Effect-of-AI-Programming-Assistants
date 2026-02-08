class Solution:
    def maximumUniqueSubarray(self, nums: List[int]) -> int:
        seen = {}
        left = max_sum = 0
        current_sum = 0

        for right in range(len(nums)):
            if nums[right] in seen:
                left = max(left, seen[nums[right]] + 1)
            seen[nums[right]] = right
            current_sum = sum(nums[left:right + 1])
            max_sum = max(max_sum, current_sum)

        return max_sum