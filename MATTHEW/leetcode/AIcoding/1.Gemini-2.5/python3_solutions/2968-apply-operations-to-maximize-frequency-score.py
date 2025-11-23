class Solution:
    def maxFrequency(self, nums: list[int], k: int) -> int:
        nums.sort()

        left = 0
        current_sum = 0
        max_freq = 0

        for right in range(len(nums)):
            current_sum += nums[right]

            # The cost to make all elements in nums[left...right] equal to nums[right]
            # is (window_length * nums[right]) - current_sum.
            # We need this cost to be less than or equal to k.
            # If it's greater than k, we shrink the window from the left.
            while (right - left + 1) * nums[right] - current_sum > k:
                current_sum -= nums[left]
                left += 1

            # At this point, the current window nums[left...right] is valid.
            # Its length (right - left + 1) is a possible frequency.
            max_freq = max(max_freq, right - left + 1)

        return max_freq