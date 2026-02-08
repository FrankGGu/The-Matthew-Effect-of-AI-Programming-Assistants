class Solution:
    def minimizeArray(self, nums: List[int]) -> List[int]:
        n = len(nums)
        for i in range(n):
            nums[i] = nums[i] & (nums[i] - 1)
        return nums