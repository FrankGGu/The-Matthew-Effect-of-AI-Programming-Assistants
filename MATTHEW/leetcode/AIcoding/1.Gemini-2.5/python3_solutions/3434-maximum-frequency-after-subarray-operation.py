class Solution:
    def maxFrequency(self, nums: list[int], k: int) -> int:
        nums.sort()

        left = 0
        current_sum = 0
        max_freq = 0

        for right in range(len(nums)):
            current_sum += nums[right]

            # While the cost to make all elements in the window nums[left...right]
            # equal to nums[right] exceeds k, shrink the window from the left.
            # Cost = (nums[right] * window_size) - current_sum_of_window
            while (nums[right] * (right - left + 1)) - current_sum > k:
                current_sum -= nums[left]
                left += 1

            # The current window is valid, update max_freq
            max_freq = max(max_freq, right - left + 1)

        return max_freq