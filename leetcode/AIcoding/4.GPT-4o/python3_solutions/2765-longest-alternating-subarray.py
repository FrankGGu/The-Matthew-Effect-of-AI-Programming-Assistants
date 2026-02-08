class Solution:
    def longestAlternatingSubarray(self, nums: List[int]) -> int:
        max_length = 0
        current_length = 1

        for i in range(1, len(nums)):
            if (nums[i] > nums[i-1] and current_length % 2 == 1) or (nums[i] < nums[i-1] and current_length % 2 == 0):
                current_length += 1
            else:
                max_length = max(max_length, current_length)
                current_length = 1

        max_length = max(max_length, current_length)
        return max_length if max_length > 1 else 0