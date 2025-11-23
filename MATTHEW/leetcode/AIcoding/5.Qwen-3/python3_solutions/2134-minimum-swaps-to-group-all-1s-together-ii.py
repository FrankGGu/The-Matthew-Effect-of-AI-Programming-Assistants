class Solution:
    def minSwaps(self, nums: List[int]) -> int:
        n = len(nums)
        total_ones = sum(nums)
        if total_ones == 0 or total_ones == n:
            return 0
        window_size = total_ones
        max_ones_in_window = 0
        current_ones = 0
        for i in range(window_size):
            current_ones += nums[i]
        max_ones_in_window = current_ones
        for i in range(window_size, n):
            current_ones += nums[i] - nums[i - window_size]
            max_ones_in_window = max(max_ones_in_window, current_ones)
        return total_ones - max_ones_in_window