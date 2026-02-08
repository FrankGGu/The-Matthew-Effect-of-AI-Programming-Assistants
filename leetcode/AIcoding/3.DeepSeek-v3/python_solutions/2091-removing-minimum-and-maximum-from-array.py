class Solution:
    def minimumDeletions(self, nums: List[int]) -> int:
        if len(nums) <= 2:
            return len(nums)

        min_val = min(nums)
        max_val = max(nums)
        min_idx = nums.index(min_val)
        max_idx = nums.index(max_val)

        left = min(min_idx, max_idx)
        right = max(min_idx, max_idx)

        option1 = right + 1
        option2 = len(nums) - left
        option3 = (left + 1) + (len(nums) - right)

        return min(option1, option2, option3)