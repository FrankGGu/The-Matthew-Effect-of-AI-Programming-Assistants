class Solution:
    def smallestRangeI(self, nums: List[int], k: int) -> int:
        min_val = min(nums)
        max_val = max(nums)

        if max_val - min_val <= 2 * k:
            return 0
        else:
            return max_val - min_val - 2 * k