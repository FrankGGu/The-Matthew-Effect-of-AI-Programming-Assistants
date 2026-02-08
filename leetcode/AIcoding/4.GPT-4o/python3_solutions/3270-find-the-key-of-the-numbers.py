class Solution:
    def findKey(self, nums):
        nums.sort()
        n = len(nums)
        if n % 2 == 1:
            return nums[n // 2]
        else:
            return nums[(n // 2) - 1]