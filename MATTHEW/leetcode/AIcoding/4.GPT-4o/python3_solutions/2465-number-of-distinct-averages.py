class Solution:
    def distinctAverages(self, nums: List[int]) -> int:
        unique_averages = set()
        nums.sort()
        n = len(nums)
        for i in range(n // 2):
            average = (nums[i] + nums[n - 1 - i]) / 2
            unique_averages.add(average)
        return len(unique_averages)