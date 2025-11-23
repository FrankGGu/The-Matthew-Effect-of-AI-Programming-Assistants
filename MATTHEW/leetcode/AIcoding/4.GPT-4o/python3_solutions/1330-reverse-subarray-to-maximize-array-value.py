class Solution:
    def maxValueAfterReverse(self, nums: List[int]) -> int:
        original_value = sum(abs(nums[i] - nums[i + 1]) for i in range(len(nums) - 1))
        max_gain = 0

        for i in range(len(nums) - 1):
            max_gain = max(max_gain, abs(nums[i] - nums[i + 1]) - (nums[i] - nums[i + 1]))
            if i > 0:
                max_gain = max(max_gain, abs(nums[i] - nums[i - 1]) - (nums[i] - nums[i - 1]))
            if i < len(nums) - 2:
                max_gain = max(max_gain, abs(nums[i] - nums[i + 2]) - (nums[i] - nums[i + 2]))

        return original_value + max_gain