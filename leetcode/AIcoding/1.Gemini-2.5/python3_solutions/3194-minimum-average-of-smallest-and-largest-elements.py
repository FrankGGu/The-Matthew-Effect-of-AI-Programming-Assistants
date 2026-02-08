class Solution:
    def minimumAverage(self, nums: list[int]) -> float:
        nums.sort()
        min_avg = float('inf')
        n = len(nums)
        for i in range(n // 2):
            current_avg = (nums[i] + nums[n - 1 - i]) / 2
            min_avg = min(min_avg, current_avg)
        return min_avg