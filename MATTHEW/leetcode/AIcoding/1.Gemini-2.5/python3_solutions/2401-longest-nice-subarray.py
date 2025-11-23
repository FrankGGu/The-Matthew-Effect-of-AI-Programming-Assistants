class Solution:
    def longestNiceSubarray(self, nums: list[int]) -> int:
        left = 0
        current_or_sum = 0
        max_len = 0

        for right in range(len(nums)):
            while (current_or_sum & nums[right]) != 0:
                current_or_sum ^= nums[left]
                left += 1

            current_or_sum |= nums[right]
            max_len = max(max_len, right - left + 1)

        return max_len