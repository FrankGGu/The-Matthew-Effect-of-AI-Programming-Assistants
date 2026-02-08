class Solution:
    def longestSubarray(self, nums: list[int]) -> int:
        max_val = 0
        for num in nums:
            if num > max_val:
                max_val = num

        max_length = 0
        current_length = 0
        for num in nums:
            if num == max_val:
                current_length += 1
            else:
                current_length = 0
            max_length = max(max_length, current_length)

        return max_length