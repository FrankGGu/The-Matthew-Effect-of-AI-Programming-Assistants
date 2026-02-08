class Solution:
    def longestNiceSubarray(self, nums: List[int]) -> int:
        left = 0
        max_len = 0
        current_or = 0

        for right in range(len(nums)):
            while (current_or & nums[right]) != 0:
                current_or ^= nums[left]
                left += 1
            current_or |= nums[right]
            max_len = max(max_len, right - left + 1)

        return max_len