class Solution:
    def longestSubarray(self, nums: List[int]) -> int:
        max_val = max(nums)
        count = 0
        max_len = 0
        for num in nums:
            if num == max_val:
                count += 1
                max_len = max(max_len, count)
            else:
                count = 0
        return max_len