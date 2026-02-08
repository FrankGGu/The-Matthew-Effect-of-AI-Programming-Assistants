class Solution:
    def minIncrementForUnique(self, nums: List[int]) -> int:
        nums.sort()
        ans = 0
        taken = 0
        for i in range(len(nums)):
            if i > 0 and nums[i] <= nums[i - 1]:
                taken = max(taken, nums[i - 1] + 1)
                ans += taken - nums[i]
                nums[i] = taken
                taken += 1
            else:
                taken = nums[i] + 1
        return ans