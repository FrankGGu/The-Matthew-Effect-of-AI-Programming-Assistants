class Solution:
    def longestAlternatingSubarray(self, nums: List[int], threshold: int) -> int:
        max_length = 0
        current_length = 0

        for num in nums:
            if num <= threshold:
                current_length += 1
                if current_length > 1 and (current_length % 2 == 0) != (nums[len(nums) - current_length] % 2 == 0):
                    max_length = max(max_length, current_length)
            else:
                current_length = 0

        return max_length