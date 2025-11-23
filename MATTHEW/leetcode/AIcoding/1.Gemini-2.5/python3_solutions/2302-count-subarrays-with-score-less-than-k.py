class Solution:
    def countSubarrays(self, nums: list[int], k: int) -> int:
        n = len(nums)
        count = 0
        left = 0
        current_sum = 0

        for right in range(n):
            current_sum += nums[right]

            # While the score of the current window is greater than or equal to k,
            # shrink the window from the left.
            # The length of the current window is (right - left + 1).
            while current_sum * (right - left + 1) >= k:
                current_sum -= nums[left]
                left += 1

            # At this point, the window [left, right] has a score less than k.
            # All subarrays ending at 'right' and starting from 'left' up to 'right'
            # will also have a score less than k (because adding elements to the left
            # would only increase the sum and length, potentially violating the condition,
            # but removing elements from the left ensures the current window is valid).
            # The number of such valid subarrays ending at 'right' is (right - left + 1).
            count += (right - left + 1)

        return count