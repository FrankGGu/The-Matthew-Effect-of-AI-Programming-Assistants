class Solution:
    def maxDifference(self, nums: list[int]) -> int:
        if not nums or len(nums) < 2:
            return 0

        n = len(nums)
        max_diff = 0

        for i in range(n - 1):
            max_diff = max(max_diff, abs(nums[i] - nums[i+1]))

        max_diff = max(max_diff, abs(nums[n-1] - nums[0]))

        return max_diff