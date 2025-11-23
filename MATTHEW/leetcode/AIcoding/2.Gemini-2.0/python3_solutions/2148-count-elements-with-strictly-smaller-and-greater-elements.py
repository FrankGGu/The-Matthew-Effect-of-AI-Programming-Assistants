class Solution:
    def countElements(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return 0
        min_val = min(nums)
        max_val = max(nums)
        count = 0
        for num in nums:
            if min_val < num < max_val:
                count += 1
        return count