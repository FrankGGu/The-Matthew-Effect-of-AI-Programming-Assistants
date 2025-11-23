class Solution:
    def getFinalArray(self, nums: list[int], operations: list[list[int]]) -> list[int]:
        for index, value in operations:
            nums[index] *= value
        return nums