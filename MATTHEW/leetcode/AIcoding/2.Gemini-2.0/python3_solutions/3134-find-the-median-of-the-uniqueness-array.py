class Solution:
    def findMedian(self, nums: list[int]) -> float:
        unique_nums = sorted(list(set(nums)))
        n = len(unique_nums)
        if n % 2 == 0:
            return (unique_nums[n // 2 - 1] + unique_nums[n // 2]) / 2
        else:
            return unique_nums[n // 2]