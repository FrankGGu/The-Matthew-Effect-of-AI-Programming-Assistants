class Solution:
    def findSpecialInteger(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return nums[0]
        count = 1
        for i in range(1, n):
            if nums[i] == nums[i - 1]:
                count += 1
                if count > n // 2:
                    return nums[i]
            else:
                count = 1
        return -1