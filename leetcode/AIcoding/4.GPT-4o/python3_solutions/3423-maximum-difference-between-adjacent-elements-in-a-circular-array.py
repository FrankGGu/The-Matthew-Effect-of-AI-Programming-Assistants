class Solution:
    def maxAdjacentDifference(self, nums: List[int]) -> int:
        max_diff = 0
        n = len(nums)
        for i in range(n):
            max_diff = max(max_diff, abs(nums[i] - nums[(i + 1) % n]))
        return max_diff