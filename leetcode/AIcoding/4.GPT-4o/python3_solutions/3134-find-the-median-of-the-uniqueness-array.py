class Solution:
    def findMedianUnique(self, nums: List[int]) -> float:
        unique_nums = list(set(nums))
        unique_nums.sort()
        n = len(unique_nums)
        if n % 2 == 1:
            return unique_nums[n // 2]
        else:
            return (unique_nums[n // 2 - 1] + unique_nums[n // 2]) / 2