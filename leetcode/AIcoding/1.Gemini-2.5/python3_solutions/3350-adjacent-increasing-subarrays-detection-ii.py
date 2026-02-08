class Solution:
    def adjacentIncreasingSubarraysDetectionII(self, nums: list[int]) -> bool:
        n = len(nums)

        if n <= 1:
            return True

        drops = 0
        for i in range(1, n):
            if nums[i] <= nums[i-1]:
                drops += 1

        return drops <= 1