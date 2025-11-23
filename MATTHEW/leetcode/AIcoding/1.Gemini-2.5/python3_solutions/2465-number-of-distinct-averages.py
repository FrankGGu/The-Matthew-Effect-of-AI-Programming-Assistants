class Solution:
    def distinctAverages(self, nums: list[int]) -> int:
        nums.sort()
        distinct_averages = set()
        left = 0
        right = len(nums) - 1

        while left < right:
            average = (nums[left] + nums[right]) / 2
            distinct_averages.add(average)
            left += 1
            right -= 1

        return len(distinct_averages)