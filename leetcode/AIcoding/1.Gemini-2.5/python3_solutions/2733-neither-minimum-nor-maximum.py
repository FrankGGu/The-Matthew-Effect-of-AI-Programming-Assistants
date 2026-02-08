class Solution:
    def findNonMinMax(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return -1

        nums.sort()
        return nums[1]