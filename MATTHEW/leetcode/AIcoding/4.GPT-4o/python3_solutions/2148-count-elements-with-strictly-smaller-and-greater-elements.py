class Solution:
    def countElements(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return 0
        return len([num for num in nums if min(nums) < num < max(nums)])