class Solution:
    def maximizeGreatness(self, nums: list[int]) -> int:
        nums.sort()
        count = 0
        j = 0
        for i in range(len(nums)):
            if nums[i] > nums[j]:
                count += 1
                j += 1
        return count