class Solution:
    def minSubArrayLen(self, target: int, nums: list[int]) -> int:
        window_start = 0
        window_sum = 0
        min_length = float('inf')

        for window_end in range(len(nums)):
            window_sum += nums[window_end]

            while window_sum >= target:
                min_length = min(min_length, window_end - window_start + 1)
                window_sum -= nums[window_start]
                window_start += 1

        if min_length == float('inf'):
            return 0
        return min_length