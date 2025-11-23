class Solution:
    def canBeIncreasing(self, nums: list[int]) -> bool:
        count = 0
        prev = -1
        for i in range(len(nums)):
            if nums[i] <= prev:
                count += 1
                if i > 1 and nums[i] <= nums[i - 2]:
                    nums[i] = nums[i - 1]
            prev = nums[i]
        return count <= 1