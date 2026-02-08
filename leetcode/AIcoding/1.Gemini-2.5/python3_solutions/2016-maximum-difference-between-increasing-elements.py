class Solution:
    def maximumDifference(self, nums: list[int]) -> int:
        max_diff = -1
        min_so_far = nums[0]

        for i in range(1, len(nums)):
            if nums[i] > min_so_far:
                max_diff = max(max_diff, nums[i] - min_so_far)
            else:
                min_so_far = nums[i]

        return max_diff