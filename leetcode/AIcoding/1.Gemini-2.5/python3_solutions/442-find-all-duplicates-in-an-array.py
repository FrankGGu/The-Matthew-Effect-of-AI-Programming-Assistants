class Solution:
    def findDuplicates(self, nums: list[int]) -> list[int]:
        duplicates = []
        for i in range(len(nums)):
            num = abs(nums[i])
            index = num - 1
            if nums[index] < 0:
                duplicates.append(num)
            else:
                nums[index] = -nums[index]
        return duplicates