class Solution:
    def maxValueAfterReverse(self, nums: List[int]) -> int:
        n = len(nums)
        total_value = 0
        for i in range(n - 1):
            total_value += abs(nums[i] - nums[i + 1])

        max_change = 0
        for i in range(n - 1):
            max_change = max(max_change, abs(nums[0] - nums[i + 1]) - abs(nums[i] - nums[i + 1]))
            max_change = max(max_change, abs(nums[n - 1] - nums[i]) - abs(nums[i] - nums[i + 1]))

        min_max_diff = float('inf')
        max_min_diff = float('-inf')
        for i in range(n - 1):
            a = nums[i]
            b = nums[i + 1]
            min_max_diff = min(min_max_diff, max(a, b))
            max_min_diff = max(max_min_diff, min(a, b))

        max_change = max(max_change, 2 * (max_min_diff - min_max_diff))

        return total_value + max_change