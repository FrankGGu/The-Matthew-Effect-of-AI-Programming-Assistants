class Solution:
    def minimumDeletions(self, nums: List[int]) -> int:
        min_val = min(nums)
        max_val = max(nums)
        min_index = nums.index(min_val)
        max_index = nums.index(max_val)
        left = min(min_index, max_index)
        right = max(min_index, max_index)
        return min(right + 1, len(nums) - left, len(nums) - right)