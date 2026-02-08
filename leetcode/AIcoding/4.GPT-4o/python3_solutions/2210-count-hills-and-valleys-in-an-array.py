class Solution:
    def countHillsAndValleys(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)

        for i in range(1, n - 1):
            if nums[i] > nums[i - 1] and nums[i] > nums[i + 1]:
                count += 1
            elif nums[i] < nums[i - 1] and nums[i] < nums[i + 1]:
                count += 1

        return count