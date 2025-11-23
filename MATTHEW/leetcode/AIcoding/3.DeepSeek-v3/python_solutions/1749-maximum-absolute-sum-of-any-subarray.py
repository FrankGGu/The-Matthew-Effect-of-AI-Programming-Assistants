class Solution:
    def maxAbsoluteSum(self, nums: List[int]) -> int:
        max_prefix = min_prefix = 0
        current_sum = 0
        max_abs = 0

        for num in nums:
            current_sum += num
            max_abs = max(max_abs, abs(current_sum - max_prefix), abs(current_sum - min_prefix))
            max_prefix = max(max_prefix, current_sum)
            min_prefix = min(min_prefix, current_sum)

        return max_abs