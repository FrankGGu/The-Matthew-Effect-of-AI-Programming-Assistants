class Solution:
    def thirdMax(self, nums: list[int]) -> int:
        nums = sorted(list(set(nums)), reverse=True)
        if len(nums) < 3:
            return nums[0]
        else:
            return nums[2]