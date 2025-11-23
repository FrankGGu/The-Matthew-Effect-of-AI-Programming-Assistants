class Solution:
    def minimizeArrayLength(self, nums: List[int]) -> int:
        return len(set(nums))