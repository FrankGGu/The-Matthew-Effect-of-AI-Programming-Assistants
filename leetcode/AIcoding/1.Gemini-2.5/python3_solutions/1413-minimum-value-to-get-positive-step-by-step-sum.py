class Solution:
    def minStartValue(self, nums: list[int]) -> int:
        min_prefix_sum = 0
        current_sum = 0

        for num in nums:
            current_sum += num
            min_prefix_sum = min(min_prefix_sum, current_sum)

        return 1 - min_prefix_sum