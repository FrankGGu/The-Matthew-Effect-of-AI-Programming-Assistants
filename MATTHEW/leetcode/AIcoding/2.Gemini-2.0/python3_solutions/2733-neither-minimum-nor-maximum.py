class Solution:
    def findNonMinOrMax(self, nums: List[int]) -> int:
        if len(nums) <= 2:
            return -1

        a, b, c = nums[0], nums[1], nums[2]

        if (a < b < c) or (c < b < a):
            return b
        elif (a < c < b) or (b < c < a):
            return c
        else:
            return a